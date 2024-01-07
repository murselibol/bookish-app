//
//  UIColor+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 7.01.2024.
//

import UIKit

extension UIColor {
    enum ColorName: String {
        case background = "bgColorColor"
        case primary = "primaryColor"
        case subtitle = "subtitleColor"
        case text = "textColor"
        case title = "titleColor"
        case textGray = "textGrayColor"
    }
    
    static func getColor(_ color: ColorName) -> UIColor {
        return UIColor(named: color.rawValue) ?? UIColor.label
    }
}
