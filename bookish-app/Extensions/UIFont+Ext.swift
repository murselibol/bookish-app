//
//  UIFont+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 22.12.2023.
//

import UIKit

extension UIFont {
    enum RalewayType: String {
        case light = "Raleway-Light"
        case lightItalic = "Raleway-LightItalic"
        case regular = "Raleway-Regular"
        case regularItalic = "Raleway-Italic"
        case medium = "Raleway-Medium"
        case semibold = "Raleway-SemiBold"
      
    }
    
    static func Raleway(_ type: RalewayType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
