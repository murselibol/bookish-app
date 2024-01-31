//
//  BookListTableViewCellVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 1.02.2024.
//

import Foundation

protocol BookListTableViewCellVMDelegate {
    func initCell()
    func onClickAuthor()
}

final class BookListTableViewCellVM {
    private weak var view: BookListTableCellViewDelegate?
    weak var authorClickListener: AuthorClickListener?
    private let arguments: BookListCellArguments
    
    init(view: BookListTableCellViewDelegate?, arguments: BookListCellArguments) {
        self.view = view
        self.arguments = arguments
        initCell()
    }
}

// MARK: - BookListTableViewCellVMDelegate
extension BookListTableViewCellVM: BookListTableViewCellVMDelegate {
    func initCell() {
        view?.constraintUI()
        view?.setUIData(data: arguments)
    }
    
    func onClickAuthor() {
        authorClickListener?.onClickAuthor(authorName: arguments.author)
    }
}
