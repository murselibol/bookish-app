//
//  BookDetailDeepLinkItem.swift
//  bookish-app
//
//  Created by Mursel Elibol on 10.02.2024.
//

import UIKit

struct BookDetailDeepLinkItem: DeepLinkableItem {
    func isSatisfied(by params: [String : Any]) -> Bool {
        guard let bookId = params["bookId"] as? String, !bookId.isEmpty else { return false }
        return true
    }
    
    func execute(params: [String : Any]) {
        guard let bookId = params["bookId"] as? String, !bookId.isEmpty else { return }
        
        if let currentNC = TabBarCoordinator.shared.rootViewController.selectedViewController as? UINavigationController {
            if currentNC.visibleViewController != nil {
                currentNC.pushViewController(BookDetailVC(id: bookId), animated: true)
            }
        }
    }
}

/*
    bookish-app://?bookId=Xdm0EAAAQBAJ
*/

