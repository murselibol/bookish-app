//
//  HomeVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 22.12.2023.
//

import Foundation

protocol HomeVMDelegate {
    func viewDidLoad()
}

final class HomeVM {
    
    private weak var view: HomeVCDelegate?
    private let bookService: BookServiceProtocol
    let categories = CATEGORY_SECTION_ITEMS
    var popularBooks: [BookResponse] = []
    var risingBooks: [BookResponse] = []
    var discoverBooks: [BookResponse] = []
    var bookOfWeak: BookResponse?
    
    // MARK: - Lifecycle
    init(view: HomeVCDelegate, bookService: BookServiceProtocol = BookService.shared) {
        self.view = view
        self.bookService = bookService
    }
    
    // MARK: - HTTP Requests
    private func getBooksByCategory(type: CategoryType, queryItems: [URLQueryItem]) {
        view?.updateIndicatorState(hidden: false)
        bookService.getBooks(queryItems: queryItems) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                switch type {
                case .history:
                    popularBooks = data.items ?? []
                    view?.reloadCollectionView()
                    view?.updateIndicatorState(hidden: true)
                    break
                case .fantasy:
                    bookOfWeak = data.items?.first
                    view?.reloadCollectionView()
                    view?.updateIndicatorState(hidden: true)
                    break
                case .love:
                    risingBooks = data.items ?? []
                    view?.reloadCollectionView()
                    view?.updateIndicatorState(hidden: true)
                    break
                case .philosophy:
                    discoverBooks = data.items ?? []
                    view?.reloadCollectionView()
                    view?.updateIndicatorState(hidden: true)
                    break
                default:
                    print("default case")
                }
            case .failure(let error):
                print(error)
                view?.updateIndicatorState(hidden: true)
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
            print("default case")
        }
        return paginationQuery
    }
    
}

// MARK: - HomeVMDelegate
extension HomeVM: HomeVMDelegate {
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
}
