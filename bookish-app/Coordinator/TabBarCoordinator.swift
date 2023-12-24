//
//  TabBarCoordinator.swift
//  bookish-app
//
//  Created by Mursel Elibol on 24.12.2023.
//

import UIKit

protocol TabBarCoordinatorProtocol: AnyObject {
    var rootViewController: UITabBarController { get set }
    var childCoordinators: [Coordinator] { get set }
}

final class TabBarCoordinator: TabBarCoordinatorProtocol {
    var rootViewController: UITabBarController
    var childCoordinators = [Coordinator]()
    
    init() {
        self.rootViewController = UITabBarController()
    }
    
    func start() {
        
    }
    
}
