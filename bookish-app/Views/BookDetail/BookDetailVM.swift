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
        self.bookService = bookService
    }
}

extension BookDetailVM: BookDetailVMDelegate {
    func viewDidLoad() {
        print("viewDidLoad")
    }
}

