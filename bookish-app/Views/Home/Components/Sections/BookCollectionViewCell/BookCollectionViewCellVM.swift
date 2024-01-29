//
//  BookCollectionViewCellVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 28.01.2024.
//

import Foundation

protocol BookCollectionViewCellVMDelegate {
    func initCell()
    func onClickBook()
}

final class BookCollectionViewCellVM {
    private weak var view: BookCollectionCellViewDelegate?
    weak var bookClickListener: BookClickListener?
    private let arguments: BookSectionArguments
    
    init(view: BookCollectionCellViewDelegate?, arguments: BookSectionArguments) {
        self.view = view
        self.arguments = arguments
        initCell()
    }
}

// MARK: - BookCollectionViewCellVMDelegate
extension BookCollectionViewCellVM: BookCollectionViewCellVMDelegate {
    func initCell() {
        view?.constraintUI()
        view?.setUIData(data: arguments)
    }
    
    func onClickBook() {
        bookClickListener?.onClickBook(id: arguments.id)
    }
}
