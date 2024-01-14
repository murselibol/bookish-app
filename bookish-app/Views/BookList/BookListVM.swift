//
//  BookListVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 8.01.2024.
//

import Foundation

protocol BookListVMDelegate {
    func viewDidLoad()
    func colletionViewWillDisplay(at indexPath: IndexPath)
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
        if let queryIndex = paginationQuery.firstIndex(where: { $0.name == "startIndex" }) {
            let currentPage = Int(paginationQuery[queryIndex].value!)! + 1
            paginationQuery.append(.init(name: "startIndex", value: String(currentPage)))
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
        getBooksByCategory(type: categoryType, queryItems: paginationQuery)
    }
    
    func colletionViewWillDisplay(at indexPath: IndexPath) {
        if indexPath.row == books.count - 3 {
            self.increasePageSize()
            getBooksByCategory(type: categoryType, queryItems: paginationQuery)
        }
    }
}
