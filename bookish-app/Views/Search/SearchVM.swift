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
    func onChangeSearchTextField(text: String)
}

final class SearchVM {

    weak var view: SearchVCDelegate?
    private let bookService: BookService
    lazy var books: [BookResponse] = []
    lazy private var querySearch: URLQueryItem = .init(name: "q", value: "")
    lazy private var queryStartIndex: URLQueryItem = .init(name: "startIndex", value: "0")
    lazy private var queryLimit: URLQueryItem = .init(name: "maxResults", value: "10")

    
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
    private func prepareQueryItems() -> [URLQueryItem] {
        return [querySearch, queryStartIndex, queryLimit]
    }
}

// MARK: - SearchVCDelegate
extension SearchVM: SearchVMDelegate {
    func viewDidLoad() {
        view?.configureCollectionViewLayout()
        view?.configureCollectionView()
        view?.constraintCollectionView()
        view?.constraintIndicatorView()
    }
    
    func colletionViewWillDisplay(at indexPath: IndexPath) {
        if indexPath.row == books.count - 3 {
            let currentPage = Int(queryStartIndex.value!)! + 10
            queryStartIndex.value = String(currentPage)
            getItemsBySearch(queryItems: prepareQueryItems())
        }
    }
    
    func onChangeSearchTextField(text: String) {
        querySearch.value = text
        guard text.count > 3 else { return }
        getItemsBySearch(queryItems: prepareQueryItems())
    }
}
