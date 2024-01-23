//
//  UIStackView+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 23.01.2024.
//

import UIKit

extension UIStackView {
    func addVerticalSeparators(color : UIColor, width: CGFloat = 1, multiplier: CGFloat = 1) {
        var i = self.arrangedSubviews.count - 1
        while i > 0 {
            let separator = createSeparator(color: color, width: width)
            insertArrangedSubview(separator, at: i)
            separator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
            i -= 1
        }
    }

    private func createSeparator(color: UIColor, width: CGFloat = 1) -> UIView {
        let separator = UIView()
        separator.widthAnchor.constraint(equalToConstant: width).isActive = true
        separator.backgroundColor = color
        return separator
    }
}
