//
//  BookCategoryCoordinator.swift
//  bookish-app
//
//  Created by Mursel Elibol on 24.12.2023.
//

import UIKit

final class BookCategoryCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    
    lazy var bookCategoryVC: BookCategoryVC = {
        let vc = BookCategoryVC()
        return vc
    }()
    
    init() {
        navigationController = UINavigationController()
    }
    
    func start() {
        navigationController.setViewControllers([bookCategoryVC], animated: false)
    }
    
    func finishCoordinator() {
        parentCoordinator?.childDidFinish(self)
    }
}
