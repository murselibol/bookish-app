//
//  AuthorBookListCoordinator.swift
//  bookish-app
//
//  Created by Mursel Elibol on 21.01.2024.
//

import UIKit

final class AuthorBookListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var authorName: String = ""
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = AuthorBookListVC(authorName: authorName)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
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
}
