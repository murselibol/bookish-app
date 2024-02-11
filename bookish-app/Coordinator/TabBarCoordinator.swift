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
    static let shared = TabBarCoordinator()
    
    var rootViewController = UITabBarController()
    var childCoordinators = [Coordinator]()
    
    private init() {}
    
    func start() {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        self.childCoordinators.append(homeCoordinator)
        let homeVC = homeCoordinator.homeVC
        createTabBarItem(vc: homeVC, title: "Home", imageName: "house", selectdImageName: "house.fill")
        
        let searchCoordinator = SearchCoordinator()
        searchCoordinator.start()
        self.childCoordinators.append(searchCoordinator)
        let searchVC = searchCoordinator.searchVC
        createTabBarItem(vc: searchVC, title: "Search", imageName: "magnifyingglass", selectdImageName: "magnifyingglass.fill")
        
        self.rootViewController.viewControllers = [homeCoordinator.navigationController, searchCoordinator.navigationController]
    }
    
    func createTabBarItem(vc: UIViewController, title: String, imageName: String, selectdImageName: String) {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectdImageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
    }
}
