//
//  UIFont+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 22.12.2023.
//

import UIKit

extension UIFont {
    enum PoppinsType: String {
        case light = "Poppins-Light"
        case lightItalic = "Poppins-LightItalic"
        case regular = "Poppins-Regular"
        case regularItalic = "Poppins-Italic"
        case medium = "Poppins-Medium"
        case semibold = "Poppins-SemiBold"
    }
    
    static func Font(_ type: PoppinsType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Title1(_ type: PoppinsType = .regular, size: CGFloat = 25.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Title2(_ type: PoppinsType = .regular, size: CGFloat = 22.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Title3(_ type: PoppinsType = .regular, size: CGFloat = 20.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Text1(_ type: PoppinsType = .regular, size: CGFloat = 17.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Text2(_ type: PoppinsType = .regular, size: CGFloat = 14.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Text3(_ type: PoppinsType = .regular, size: CGFloat = 12.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func Description(_ type: PoppinsType = .regular, size: CGFloat = 13.0) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
