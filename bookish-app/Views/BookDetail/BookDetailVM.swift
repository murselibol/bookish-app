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
    
    init(view: BookDetailVCDelegate?, id: String, bookService: BookService = BookService.shared) {
        self.view = view
        self.bookId = id
        self.bookService = bookService
    }
    
    // MARK: - HTTP Requests
    private func getBook(id: String, queryItems: [URLQueryItem] = []) {
//        view?.updateIndicatorState(hidden: false)
        bookService.getBook(id: id, queryItems: queryItems) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                print(data)
//                bookOfWeak = data.items ?? nil
//                view?.reloadCollectionView()
//                view?.updateIndicatorState(hidden: true)
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

extension BookDetailVM: BookDetailVMDelegate {
    func viewDidLoad() {
        getBook(id: bookId)
    }
}

