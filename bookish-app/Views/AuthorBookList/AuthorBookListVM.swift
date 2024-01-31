//
//  AuthorBookListVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 21.01.2024.
//

import Foundation

protocol AuthorBookListVMDelegate {
    func viewDidLoad()
    func tableCellForItem(at indexPath: IndexPath) -> BookListCellArguments
    func didSelectRow(at indexPath: IndexPath)
    func tableViewWillDisplay(at indexPath: IndexPath)
}

final class AuthorBookListVM {

    weak var view: AuthorBookListVCDelegate?
    private let bookService: BookService
    var authorName: String
    lazy var books: [BookResponse] = []
    private lazy var paginationQuery: [URLQueryItem] = [
        .init(name: "q", value: "inauthor:\(authorName)"),
        .init(name: "startIndex", value: "0"),
        .init(name: "maxResults", value: "10")
    ]
    
    // MARK: - Lifecycle
    init(view: AuthorBookListVCDelegate?, authorName: String, bookService: BookService = BookService.shared) {
        self.view = view
        self.authorName = authorName
        self.bookService = bookService
    }
    
    // MARK: - HTTP Requests
    private func getBooksByAuthor(author: String, queryItems: [URLQueryItem]) {
        view?.updateIndicatorState(hidden: false)
        bookService.getBooks(queryItems: queryItems) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.books.append(contentsOf: data.items ?? [])
                view?.reloadBookListTableView()
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
        if let queryIndex = paginationQuery.firstIndex(where: { $0.name == "startIndex" }) {
            let currentPage = Int(paginationQuery[queryIndex].value!)! + 10
            paginationQuery[queryIndex].value = String(currentPage)
            getBooksByAuthor(author: authorName, queryItems: paginationQuery)
        }
    }
}

// MARK: - AuthorBookListVMDelegate
extension AuthorBookListVM: AuthorBookListVMDelegate {
    var numberOfRowsInSection: Int { books.count }
    
    func viewDidLoad() {
        view?.configureBookListTableView()
        view?.constraintBookListTableView()
        view?.constraintIndicatorView()
        getBooksByAuthor(author: authorName, queryItems: paginationQuery)
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
