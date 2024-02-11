//
//  DeepLinkableItem.swift
//  bookish-app
//
//  Created by Mursel Elibol on 10.02.2024.
//

import UIKit

protocol DeepLinkableItem {
    func isSatisfied(by params: [String: Any]) -> Bool
    func execute(params: [String: Any])
}
