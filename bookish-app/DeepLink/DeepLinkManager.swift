//
//  DeepLinkManager.swift
//  bookish-app
//
//  Created by Mursel Elibol on 10.02.2024.
//

import UIKit

class DeepLinkManager {
    static let shared: DeepLinkManager = DeepLinkManager()
    
    private init() {}
    
    private let items: [DeepLinkableItem] = [BookDetailDeepLinkItem(),
                                            AuthorBookListDeepLinkItem()]
    
    func navigate(with params: [String: Any]) {
        items.first(where: { $0.isSatisfied(by: params)})?.execute(params: params)
    }
}
