//
//  BookDetailVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import Foundation

protocol BookDetailVMDelegate {
    func viewDidLoad()
}

final class BookDetailVM {
    
    weak var view: BookDetailVCDelegate?
    private let bookService: BookService
    var bookId: String = ""
    var book: BookResponse?
    
    init(view: BookDetailVCDelegate?, id: String, bookService: BookService = BookService.shared) {
        self.view = view
        self.bookId = id
        self.bookService = bookService
    }
    
    // MARK: - HTTP Requests
    private func getBook(id: String, queryItems: [URLQueryItem] = []) {
        view?.updateIndicatorState(hidden: false)
        bookService.getBook(id: id, queryItems: queryItems) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                book = data
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

extension BookDetailVM: BookDetailVMDelegate {
    func viewDidLoad() {
        view?.configureCollectionViewLayout()
        view?.configureCollectionView()
        view?.constraintCollectionView()
        view?.constraintIndicatorView()
        getBook(id: bookId)
    }
}

