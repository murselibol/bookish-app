//
//  UITableViewCell+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 24.02.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var longPressGesture: UILongPressGestureRecognizer!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLongPressGesture()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLongPressGesture()
    }

    private func setupLongPressGesture() {
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        self.addGestureRecognizer(longPressGesture)
    }

    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            print("Cell long pressed!")
        }
    }
}
