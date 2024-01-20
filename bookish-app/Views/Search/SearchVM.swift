//
//  SearchVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 20.01.2024.
//

import UIKit

protocol SearchVMDelegate {
    func viewDidLoad()
    func colletionViewWillDisplay(at indexPath: IndexPath)
}

final class SearchVM {

    weak var view: SearchVCDelegate?
    private let bookService: BookService
    lazy var books: [BookResponse] = []
    private lazy var paginationQuery: [URLQueryItem] = [
        .init(name: "q", value: "sineklerin tanrisi"),
        .init(name: "startIndex", value: "0"),
        .init(name: "maxResults", value: "10")
    ]
    
    // MARK: - Lifecycle
    init(view: SearchVCDelegate?, bookService: BookService = BookService.shared) {
        self.view = view
        self.bookService = bookService
    }
    
    // MARK: - HTTP Requests
    private func getItemsBySearch(queryItems: [URLQueryItem]) {
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
            let currentPage = Int(paginationQuery[queryIndex].value!)! + 10
            paginationQuery[queryIndex].value = String(currentPage)
            getItemsBySearch(queryItems: paginationQuery)
        }
    }
}

// MARK: - SearchVCDelegate
extension SearchVM: SearchVMDelegate {
    func viewDidLoad() {
        view?.configureCollectionViewLayout()
        view?.configureCollectionView()
        view?.constraintCollectionView()
        view?.constraintIndicatorView()
        getItemsBySearch(queryItems: paginationQuery)
    }
    
    func colletionViewWillDisplay(at indexPath: IndexPath) {
        if indexPath.row == books.count - 3 {
            self.increasePageSize()
        }
    }
}
