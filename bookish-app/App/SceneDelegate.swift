//
//  SceneDelegate.swift
//  bookish-app
//
//  Created by Mursel Elibol on 22.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            
            let window = UIWindow(windowScene: windowScene)
            let applicationCoordinator = ApplicationCoordinator(window: window)
            applicationCoordinator.start()
            self.applicationCoordinator = applicationCoordinator
            window.makeKeyAndVisible()
            
            DispatchQueue.global(qos: .userInteractive).async {
                if let query = connectionOptions.urlContexts.first?.url.query {
                    deeplinkToOpen = self.createMap(from: query)
                }
            }
            
            if #available(iOS 13.0, *) {
                window.overrideUserInterfaceStyle = .dark
            }
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let query = URLContexts.first?.url.query else { return }
        executeDeepLink(with: query)
    }

    private func executeDeepLink(with query: String) {
        let params = createMap(from: query)
        DeepLinkManager.shared.navigate(with: params)
    }
    
    private func createMap(from query: String) -> [String: Any] {
        let queryItems = query.components(separatedBy: "&")
        var params = [String: Any]()
        queryItems.forEach { (keyValue) in
            let separatedItems = keyValue.components(separatedBy: "=")
            params[separatedItems.first!] = separatedItems.last
        }
        return params
    }

}

