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
    let categories = CATEGORY_SECTION_ITEMS
    
    init(view: HomeVCDelegate) {
        self.view = view
    }
    
}

// MARK: - HomeVMDelegate
extension HomeVM: HomeVMDelegate {
    func viewDidLoad() {
        view?.configureCollectionViewLayout()
        view?.configureCollectionView()
        view?.constraintsCollectionView()
    }
    
    
}
