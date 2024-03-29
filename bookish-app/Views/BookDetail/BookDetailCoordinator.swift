//
//  BookDetailCoordinator.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import UIKit

final class BookDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var id: String = ""
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BookDetailVC(id: id)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finishCoordinator() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func navigateAuthorBookListVC(authorName: String) {
        let coordinator = AuthorBookListCoordinator(navigationController: navigationController)
        coordinator.authorName = authorName
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
