//
//  CGPoint+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 24.02.2024.
//

import Foundation

extension CGPoint {
    func isContained(in rect: CGRect) -> Bool {
        return rect.contains(self)
    }
}
