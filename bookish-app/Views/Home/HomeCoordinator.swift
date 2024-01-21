//
//  HomeC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 22.12.2023.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    
    lazy var homeVC: HomeVC = {
        let vc = HomeVC()
        vc.coordinator = self
        return vc
    }()
    
    init() {
        navigationController = UINavigationController()
    }
    
    func start() {
        navigationController.setViewControllers([homeVC], animated: false)
    }
    
    func finishCoordinator() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func navigateBookDetailVC(id: String) {
        let coordinator = BookDetailCoordinator(navigationController: navigationController)
        coordinator.id = id
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func navigateBookListVC(title: String, category: CategoryType) {
        let coordinator = BookListCoordinator(navigationController: navigationController)
        coordinator.title = title
        coordinator.category = category
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func navigateAuthorBookListVC(authorName: String) {
        let coordinator = AuthorBookListCoordinator(navigationController: navigationController)
        coordinator.authorName = authorName
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
