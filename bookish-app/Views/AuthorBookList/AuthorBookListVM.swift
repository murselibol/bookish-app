//
//  AuthorBookListVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 21.01.2024.
//

import Foundation

protocol AuthorBookListVMDelegate {
    func viewDidLoad()
    func colletionViewWillDisplay(at indexPath: IndexPath)
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
                view?.reloadCollectionView()
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
            getBooksByAuthor(author: authorName, queryItems: paginationQuery)
        }
    }
}

// MARK: - AuthorBookListVMDelegate
extension AuthorBookListVM: BookListVMDelegate {
    func viewDidLoad() {
        view?.configureCollectionViewLayout()
        view?.configureCollectionView()
        view?.constraintCollectionView()
        view?.constraintIndicatorView()
        getBooksByAuthor(author: authorName, queryItems: paginationQuery)
    }
    
    func colletionViewWillDisplay(at indexPath: IndexPath) {
        if indexPath.row == books.count - 3 {
            self.increasePageSize()
        }
    }
}
