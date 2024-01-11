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
    var paginationQuery: [String: String] = [
        "q": "subject:love",
        "startIndex": "0",
        "maxResults": "5",
    ]
    
    // MARK: - Life Cycle
    init(view: HomeVCDelegate, bookService: BookServiceProtocol = BookService.shared) {
        self.view = view
        self.bookService = bookService
    }
    
    // MARK: - HTTP Requests
    func getBooks() {
        bookService.getBooks(queryItems: paginationQuery) { result in
            switch result {
            case .success(let data):
                self.popularBooks = data.items ?? []
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}

// MARK: - HomeVMDelegate
extension HomeVM: HomeVMDelegate {
    func viewDidLoad() {
        view?.configureCollectionViewLayout()
        view?.configureCollectionView()
        view?.constraintsCollectionView()
        getBooks()
    }
    
    
}
