//
//  RisingCollectionViewCellVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 29.01.2024.
//

import Foundation

protocol RisingCollectionViewCellVMDelegate {
    func initCell()
    func getRankImageColorByRank(rank: String) -> String
    func getRankLabelByRank(rank: String) -> String
    func onClickBook()
    func onClickAuthor()
}

final class RisingCollectionViewCellVM {
    private weak var view: RisingCollectionCellViewDelegate?
    weak var bookClickListener: BookClickListener?
    weak var authorClickListener: AuthorClickListener?
    private let arguments: RisingSectionArguments
    
    init(view: RisingCollectionCellViewDelegate?, arguments: RisingSectionArguments) {
        self.view = view
        self.arguments = arguments
        initCell()
    }
}

// MARK: - RisingCollectionViewCellVMDelegate
extension RisingCollectionViewCellVM: RisingCollectionViewCellVMDelegate {
    func initCell() {
        view?.constraintUI()
        view?.setUIData(data: arguments)
    }
    
    func getRankImageColorByRank(rank: String) -> String {
        guard let rankIndex = Int(rank) else { return "" }
        return CATEGORY_SECTION_COLORS[(rankIndex - 1) % 10]
    }
    
    func getRankLabelByRank(rank: String) -> String {
        return Int(rank)! >= 10 ? rank : "0\(rank)"
    }
    
    func onClickBook() {
        bookClickListener?.onClickBook(id: arguments.id)
    }
    
    func onClickAuthor() {
        authorClickListener?.onClickAuthor(authorName: arguments.author)
    }
}
