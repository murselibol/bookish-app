//
//  SearchCoordinator.swift
//  bookish-app
//
//  Created by Mursel Elibol on 20.01.2024.
//

import UIKit

final class SearchCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    
    lazy var searchVC: SearchVC = {
        let vc = SearchVC()
        vc.coordinator = self
        return vc
    }()
    
    init() {
        navigationController = UINavigationController()
    }
    
    func start() {
        navigationController.setViewControllers([searchVC], animated: false)
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
    
    func navigateAuthorBookListVC(authorName: String) {
        let coordinator = AuthorBookListCoordinator(navigationController: navigationController)
        coordinator.authorName = authorName
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
