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
    
    static func Title1(_ type: RalewayType = .medium, size: CGFloat = 28.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Title2(_ type: RalewayType = .medium, size: CGFloat = 22.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Title3(_ type: RalewayType = .regular, size: CGFloat = 20.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Text1(_ type: RalewayType = .regular, size: CGFloat = 17.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Text2(_ type: RalewayType = .regular, size: CGFloat = 14.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Text3(_ type: RalewayType = .regular, size: CGFloat = 12.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
