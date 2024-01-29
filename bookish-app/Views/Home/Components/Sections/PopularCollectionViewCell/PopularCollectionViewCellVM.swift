//
//  PopularCollectionViewCellVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 28.01.2024.
//

import Foundation

protocol PopularCollectionViewCellVMDelegate {
    func initCell()
    func onClickBook()
}

final class PopularCollectionViewCellVM {
    private weak var view: PopularCollectionCellViewDelegate?
    weak var bookClickListener: BookClickListener?
    private let arguments: PopularSectionArguments
    
    init(view: PopularCollectionCellViewDelegate?, arguments: PopularSectionArguments) {
        self.view = view
        self.arguments = arguments
        initCell()
    }
}

// MARK: - PopularCollectionViewCellVMDelegate
extension PopularCollectionViewCellVM: PopularCollectionViewCellVMDelegate {
    func initCell() {
        view?.constraintUI()
        view?.setUIData(data: arguments)
    }
    
    func onClickBook() {
        bookClickListener?.onClickBook(id: arguments.id)
    }
}
