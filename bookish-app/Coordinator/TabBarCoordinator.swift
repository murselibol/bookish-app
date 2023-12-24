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
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        self.childCoordinators.append(homeCoordinator)
        let homeVC = homeCoordinator.homeVC
        createTabBarItem(vc: homeVC, title: "Home", imageName: "house", selectdImageName: "house.fill")
        
        
        self.rootViewController.viewControllers = [homeCoordinator.navigationController]
    }
    
    func createTabBarItem(vc: UIViewController, title: String, imageName: String, selectdImageName: String) {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectdImageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
    }
}
