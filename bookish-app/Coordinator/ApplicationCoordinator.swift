//
//  ApplicationCoordinator.swift
//  bookish-app
//
//  Created by Mursel Elibol on 24.12.2023.
//

import UIKit

protocol ApplicationCoordinatorProtocol: AnyObject {
    var childCoordinators: [TabBarCoordinator] { get set }
    func start()
}

final class ApplicationCoordinator: ApplicationCoordinatorProtocol {
    var childCoordinators = [TabBarCoordinator]()
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarController = TabBarCoordinator.shared
        tabBarController.start()
        self.childCoordinators = [tabBarController]
        window.rootViewController = tabBarController.rootViewController
    }
}
