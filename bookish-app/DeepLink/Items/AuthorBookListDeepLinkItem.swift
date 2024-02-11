//
//  AuthorBookListDeepLinkItem.swift
//  bookish-app
//
//  Created by Mursel Elibol on 11.02.2024.
//

import UIKit

struct AuthorBookListDeepLinkItem: DeepLinkableItem {
    func isSatisfied(by params: [String : Any]) -> Bool {
        guard let authorName = params["authorName"] as? String, !authorName.isEmpty else { return false }
        return true
    }
    
    func execute(params: [String : Any]) {
        guard let authorName = params["authorName"] as? String, !authorName.isEmpty else { return }
        let convertedAuthorName = authorName.components(separatedBy: "+").map { $0.capitalized }.joined(separator: " ")
        
        if let currentNC = TabBarCoordinator.shared.rootViewController.selectedViewController as? UINavigationController {
            if currentNC.visibleViewController != nil {
                currentNC.pushViewController(AuthorBookListVC(authorName: convertedAuthorName), animated: true)
            }
        }
    }
}


/*
    bookish-app://?authorName=paulo+coelho
*/
