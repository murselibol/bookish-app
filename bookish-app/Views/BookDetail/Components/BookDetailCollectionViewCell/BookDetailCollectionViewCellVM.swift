//
//  BookDetailCollectionViewCellVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 14.01.2024.
//

import Foundation

protocol BookDetailCollectionViewCellVMDelegate {
    var isOpenReadMore: Bool { get }
    func viewInit()
}

final class BookDetailCollectionViewCellVM {
    
    weak var view: BookDetailCollectionCellDelegate?
    var isOpenReadMore: Bool = false
    
    init(view: BookDetailCollectionCellDelegate?) {
        self.view = view
    }
    
}

extension BookDetailCollectionViewCellVM: BookDetailCollectionViewCellVMDelegate {
    func viewInit() {
        
    }
}
