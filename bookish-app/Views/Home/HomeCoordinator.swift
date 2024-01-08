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
    
    func navigateBookListVC() {
        let coordinator = BookListCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
