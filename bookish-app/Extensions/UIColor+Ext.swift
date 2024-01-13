//
//  UIColor+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 7.01.2024.
//

import UIKit

extension UIColor {
    enum ColorName: String {
        case background = "bgColor"
        case bookTitle = "bookTitleColor"
        case moreBtnText = "moreBtnTextColor"
        case primary = "primaryColor"
        case subtitle = "subtitleColor"
        case text = "textColor"
        case title = "titleColor"
        case textGray = "textGrayColor"
    }
    
    static func getColor(_ color: ColorName) -> UIColor {
        return UIColor(named: color.rawValue) ?? UIColor.label
    }
    
    // MARK: - Hex Color
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

}
