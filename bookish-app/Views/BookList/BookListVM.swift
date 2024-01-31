//
//  BookListVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 8.01.2024.
//

import Foundation

protocol BookListVMDelegate {
    var pageTitle: String { get }
    var numberOfRowsInSection: Int { get }
    func viewDidLoad()
    func tableCellForItem(at indexPath: IndexPath) -> BookListCellArguments
    func didSelectRow(at indexPath: IndexPath)
    func tableViewWillDisplay(at indexPath: IndexPath)
}

final class BookListVM {

    weak var view: BookListVCDelegate?
    private let bookService: BookService
    var pageTitle: String
    var categoryType: CategoryType
    lazy var books: [BookResponse] = []
    private lazy var paginationQuery: [URLQueryItem] = [
        .init(name: "q", value: "subject:\(categoryType)"),
        .init(name: "startIndex", value: "0"),
        .init(name: "maxResults", value: "10")
    ]
    
    // MARK: - Lifecycle
    init(view: BookListVCDelegate?, title: String, category: CategoryType, bookService: BookService = BookService.shared) {
        self.view = view
        self.pageTitle = title
        self.categoryType = category
        self.bookService = bookService
    }
    
    // MARK: - HTTP Requests
    private func getBooksByCategory(type: CategoryType, queryItems: [URLQueryItem]) {
        view?.updateIndicatorState(hidden: false)
        bookService.getBooks(queryItems: queryItems) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.books.append(contentsOf: data.items ?? [])
                view?.reloadTableView()
                view?.updateIndicatorState(hidden: true)
            case .failure(let error):
                print(error)
                view?.updateIndicatorState(hidden: true)
                break
            }
        }
    }
    
    // MARK: - Functions
    func increasePageSize() {
        /**
         for [0-10] item: startIndex: 0 - maxResults: 10
         for [10-20] item: startIndex: 10 - maxResults: 10
         **/
        if let queryIndex = paginationQuery.firstIndex(where: { $0.name == "startIndex" }) {
            let currentPage = Int(paginationQuery[queryIndex].value!)! + 10
            paginationQuery[queryIndex].value = String(currentPage)
            getBooksByCategory(type: categoryType, queryItems: paginationQuery)
        }
    }
}

// MARK: - BookListVMDelegate
extension BookListVM: BookListVMDelegate {
    var pageTitleLabel: String { pageTitle }
    var numberOfRowsInSection: Int { books.count }
    func viewDidLoad() {
        view?.configureTableView()
        view?.constraintTableView()
        view?.constraintIndicatorView()
        getBooksByCategory(type: categoryType, queryItems: paginationQuery)
    }
    
    func tableCellForItem(at indexPath: IndexPath) -> BookListCellArguments {
         let book = books[indexPath.item].volumeInfo
         let id = books[indexPath.item].id ?? ""
         let thumbnailUrl = book?.imageLinks?.smallThumbnail
         let title = book?.title ?? "-"
         let author = book?.authors?.first ?? "-"
         let description = book?.description ?? "-"
         return BookListCellArguments(id: id, thumbnailUrl: thumbnailUrl, title: title, author: author, description: description)
     }
    
    func didSelectRow(at indexPath: IndexPath) {
        view?.navigateBookDetailVC(id: books[indexPath.row].id ?? "")
    }
    
    func tableViewWillDisplay(at indexPath: IndexPath) {
        if indexPath.row == books.count - 3 {
            self.increasePageSize()
        }
    }
}
