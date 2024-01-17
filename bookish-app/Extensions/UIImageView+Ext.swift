//
//  UIImageView+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import SDWebImage

extension UIImageView {
    func loadURL(url: String?, placeholderImageName: String = "image-not-found") {
        if let urlString = url, let url = URL(string: urlString) {
            sd_setImage(with: url, placeholderImage: UIImage(named: placeholderImageName))
        } else {
            sd_setImage(with: nil, placeholderImage: UIImage(named: placeholderImageName))
        }
    }
}


