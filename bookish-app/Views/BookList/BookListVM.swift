//
//  BookListVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 8.01.2024.
//

import Foundation

protocol BookListVMDelegate {
    func viewDidLoad()
}

final class BookListVM {

    weak var view: BookListVCDelegate?
    private let bookService: BookService
    var categoryType: CategoryType
    lazy var books: [BookResponse] = []
    private lazy var paginationQuery: [URLQueryItem] = [
        .init(name: "q", value: "subject:\(categoryType)"),
        .init(name: "startIndex", value: "0"),
        .init(name: "maxResults", value: "10")
    ]
    
    // MARK: - Lifecycle
    init(view: BookListVCDelegate?, category: CategoryType, bookService: BookService = BookService.shared) {
        self.view = view
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
                books = data.items ?? []
                view?.reloadCollectionView()
                view?.updateIndicatorState(hidden: true)
            case .failure(let error):
                print(error)
                view?.updateIndicatorState(hidden: true)
                break
            }
        }
    }
}

// MARK: - BookListVMDelegate
extension BookListVM: BookListVMDelegate {
    func viewDidLoad() {
        view?.configureCollectionViewLayout()
        view?.configureCollectionView()
        view?.constraintCollectionView()
        view?.constraintIndicatorView()
        getBooksByCategory(type: .history, queryItems: paginationQuery)
    }
}

