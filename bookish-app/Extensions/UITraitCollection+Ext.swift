//
//  UITraitCollection+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 24.02.2024.
//

import UIKit

enum ThemeMode {
    case light
    case dark
    
    static var mode: ThemeMode {
        get {  UITraitCollection.current.userInterfaceStyle == .dark ? .dark : .light }
        
        set {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.overrideUserInterfaceStyle = newValue == ThemeMode.dark ? UIUserInterfaceStyle.dark : UIUserInterfaceStyle.light
            }
        }
    }

}

