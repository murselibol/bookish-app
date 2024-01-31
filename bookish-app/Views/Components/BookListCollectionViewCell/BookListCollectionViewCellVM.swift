//
//  BookListCollectionViewCellVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 1.02.2024.
//

import Foundation

protocol BookListCollectionViewCellVMDelegate {
    func initCell()
    func onClickBook()
    func onClickAuthor()
}

final class BookListCollectionViewCellVM {
    private weak var view: BookListCollectionCellViewDelegate?
    weak var bookClickListener: BookClickListener?
    weak var authorClickListener: AuthorClickListener?
    private let arguments: BookListCellArguments
    
    init(view: BookListCollectionCellViewDelegate?, arguments: BookListCellArguments) {
        self.view = view
        self.arguments = arguments
        initCell()
    }
}

// MARK: - BookListCollectionViewCellVMDelegate
extension BookListCollectionViewCellVM: BookListCollectionViewCellVMDelegate {
    func initCell() {
        view?.constraintUI()
        view?.setUIData(data: arguments)
    }
    
    func onClickBook() {
        bookClickListener?.onClickBook(id: arguments.id)
    }
    
    func onClickAuthor() {
        authorClickListener?.onClickAuthor(authorName: arguments.author)
    }
}
