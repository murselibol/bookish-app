//
//  HomeVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 22.12.2023.
//

import Foundation

protocol HomeVMDelegate {
    var numberOfSections: Int { get }
    func viewDidLoad()
    func viewWillAppear()
    func getLayoutSectionByIndex(index: Int) -> HomeCompostionalLayoutSection
    func numberOfItemsInSection(index: Int) -> Int
    func popularCellForItem(at indexPath: IndexPath) -> PopularSectionArguments
    func categoryCellForItem(at indexPath: IndexPath) -> CategorySectionArguments
    func bookCellForItem() -> BookSectionArguments
    func risingCellForItem(at indexPath: IndexPath) -> RisingSectionArguments
    func discoverCellForItem(at indexPath: IndexPath) -> BookListCellArguments
    func getHeaderItemBySection(index: Int) -> TitleCollectionReuseViewArguments?
    func getListVCArgumentsBySection(index: Int) -> (title: String, category: CategoryType)
}

final class HomeVM {
    
    private weak var view: HomeVCDelegate?
    private let bookService: BookServiceProtocol
    private let categories = CATEGORY_SECTION_ITEMS
    private lazy var sectionTypes: [HomeSectionType] = [.popular, .category, .book, .rising, .discover]
    private lazy var popularBooks: [BookResponse] = []
    private lazy var risingBooks: [BookResponse] = []
    private lazy var discoverBooks: [BookResponse] = []
    private var bookOfWeak: BookResponse!
    
    // MARK: - Lifecycle
    init(view: HomeVCDelegate, bookService: BookServiceProtocol = BookService.shared) {
        self.view = view
        self.bookService = bookService
    }
    
    // MARK: - HTTP Requests
    private func getBooksByCategory(type: CategoryType, queryItems: [URLQueryItem]) {
        view?.startLoading()
        bookService.getBooks(queryItems: queryItems) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                switch type {
                case .history:
                    popularBooks = data.items ?? []
                    view?.reloadCollectionView()
                    view?.stopLoading()
                    break
                case .fantasy:
                    bookOfWeak = data.items?.first
                    view?.reloadCollectionView()
                    view?.stopLoading()
                    break
                case .love:
                    risingBooks = data.items ?? []
                    view?.reloadCollectionView()
                    view?.stopLoading()
                    break
                case .philosophy:
                    discoverBooks = data.items ?? []
                    view?.reloadCollectionView()
                    view?.stopLoading()
                    break
                default:
                    print("default case")
                }
            case .failure(let error):
                print(error)
                view?.stopLoading()
                break
            }
        }
    }
    
    // MARK: - Functions
    private func getInitialQueryItemsByCategory(type: CategoryType) -> [URLQueryItem] {
        var paginationQuery: [URLQueryItem] = []
        
        switch type {
        case .history:
            paginationQuery.append(.init(name: "q", value: "subject:history"))
            paginationQuery.append(.init(name: "maxResults", value: "10"))
            break
        case .fantasy:
            paginationQuery.append(.init(name: "q", value: "subject:fantasy"))
            paginationQuery.append(.init(name: "maxResults", value: "1"))
            break
        case .love:
            paginationQuery.append(.init(name: "q", value: "subject:love"))
            paginationQuery.append(.init(name: "maxResults", value: "9"))
            break
        case .philosophy:
            paginationQuery.append(.init(name: "q", value: "subject:philosophy"))
            paginationQuery.append(.init(name: "maxResults", value: "4"))
            break
        default:
            paginationQuery.append(.init(name: "q", value: "subject:fantasy"))
            paginationQuery.append(.init(name: "maxResults", value: "1"))
        }
        return paginationQuery
    }
}

// MARK: - HomeVMDelegate
extension HomeVM: HomeVMDelegate {
    var numberOfSections: Int { sectionTypes.count }
    
    func viewDidLoad() {
        view?.configureCollectionViewLayout()
        view?.configureCollectionView()
        view?.constraintCollectionView()
        view?.constraintIndicatorView()
        getBooksByCategory(type: .history, queryItems: getInitialQueryItemsByCategory(type: .history))
        getBooksByCategory(type: .fantasy, queryItems: getInitialQueryItemsByCategory(type: .fantasy))
        getBooksByCategory(type: .love, queryItems: getInitialQueryItemsByCategory(type: .love))
        getBooksByCategory(type: .philosophy, queryItems: getInitialQueryItemsByCategory(type: .philosophy))
    }
    
    func viewWillAppear() {
        if let deeplink = deeplinkToOpen {
            DeepLinkManager.shared.navigate(with: deeplink)
            deeplinkToOpen = nil
        }
    }
    
    func getLayoutSectionByIndex(index: Int) -> HomeCompostionalLayoutSection {
        return sectionTypes[index].createLayoutSection()
    }
    
    func numberOfItemsInSection(index: Int) -> Int {
        switch index {
            case 0: return popularBooks.count
            case 1: return categories.count
            case 2: return 1
            case 3: return risingBooks.count
            case 4: return discoverBooks.count
            default: return 0
        }
    }
    
    func popularCellForItem(at indexPath: IndexPath) -> PopularSectionArguments {
         let book = popularBooks[indexPath.item].volumeInfo
         let id = popularBooks[indexPath.item].id ?? ""
         let thumbnailUrl = book?.imageLinks?.smallThumbnail
         let title = book?.title ?? "-"
         return PopularSectionArguments(id: id, thumbnailUrl: thumbnailUrl, title: title)
     }
    
    func categoryCellForItem(at indexPath: IndexPath) -> CategorySectionArguments {
        return categories[indexPath.item]
    }
    
    func bookCellForItem() -> BookSectionArguments {
         let book = bookOfWeak?.volumeInfo
         let id = bookOfWeak?.id ?? ""
         let thumbnailUrl = book?.imageLinks?.smallThumbnail
         let title = book?.title ?? "-"
         let description = book?.description ?? "-"
         return BookSectionArguments(id: id, thumbnailUrl: thumbnailUrl, title: title, description: description)
     }
    
    func risingCellForItem(at indexPath: IndexPath) -> RisingSectionArguments {
         let book = risingBooks[indexPath.item].volumeInfo
         let id = risingBooks[indexPath.item].id ?? ""
         let thumbnailUrl = book?.imageLinks?.smallThumbnail
         let rank = "\(indexPath.item + 1)"
         let title = book?.title ?? "-"
         let author = book?.authors?.first ?? "-"
         return RisingSectionArguments(id: id, thumbnailUrl: thumbnailUrl, rank: rank, title: title, author: author)
     }
    
    func discoverCellForItem(at indexPath: IndexPath) -> BookListCellArguments {
         let book = discoverBooks[indexPath.item].volumeInfo
         let id = discoverBooks[indexPath.item].id ?? ""
         let thumbnailUrl = book?.imageLinks?.smallThumbnail
         let title = book?.title ?? "-"
         let author = book?.authors?.first ?? "-"
         let description = book?.description ?? "-"
         return BookListCellArguments(id: id, thumbnailUrl: thumbnailUrl, title: title, author: author, description: description)
     }
    
    func getHeaderItemBySection(index: Int) -> TitleCollectionReuseViewArguments? {
        switch index {
            case 0: 
                TitleCollectionReuseViewArguments(title: HomeSectionType.popular.sectionTitle, sectionIndex: index, hiddenSeeMore: false)
            case 2: 
                TitleCollectionReuseViewArguments(title: HomeSectionType.book.sectionTitle, sectionIndex: index, hiddenSeeMore: true)
            case 3: 
                TitleCollectionReuseViewArguments(title: HomeSectionType.rising.sectionTitle, sectionIndex: index, hiddenSeeMore: false)
            case 4: 
                TitleCollectionReuseViewArguments(title: HomeSectionType.discover.sectionTitle, sectionIndex: index, hiddenSeeMore: false)
            default: nil
        }
    }
    
    func getListVCArgumentsBySection(index: Int) -> (title: String, category: CategoryType) {
        let sectionType = sectionTypes[index]
        return (title: sectionType.sectionTitle, category: sectionType.sectionCategory)
    }
}
