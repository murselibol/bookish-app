//
//  UITextField+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 10.02.2024.
//

import UIKit

extension UITextField {
    private static var debounceTimer: Timer?

    func debounce(_ delay: TimeInterval, closure: @escaping (String) -> Void) {
        Self.debounceTimer?.invalidate()
        Self.debounceTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] timer in
            if let text = self?.text {
                DispatchQueue.main.async {
                    closure(text)
                }
            }
        }
    }
}
