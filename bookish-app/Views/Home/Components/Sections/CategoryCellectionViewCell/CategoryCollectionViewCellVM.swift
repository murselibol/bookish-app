//
//  CategoryCollectionViewCellVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 28.01.2024.
//

import Foundation

protocol CategoryCollectionViewCellVMDelegate {
    func initCell()
    func onClickCategory()
}

final class CategoryCollectionViewCellVM {
    private weak var view: CategoryCollectionCellViewDelegate?
    weak var categoryClickListener: CategoryClickListener?
    private let arguments: CategorySectionArguments
    
    init(view: CategoryCollectionCellViewDelegate?, arguments: CategorySectionArguments) {
        self.view = view
        self.arguments = arguments
        initCell()
    }
}

// MARK: - CategoryCollectionViewCellVMDelegate
extension CategoryCollectionViewCellVM: CategoryCollectionViewCellVMDelegate {
    func initCell() {
        view?.constraintUI()
        view?.setUIData(data: arguments)
    }
    
    func onClickCategory() {
        categoryClickListener?.onClickCategory(category: arguments.type)
    }
}
