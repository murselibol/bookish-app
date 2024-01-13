//
//  UIImageView+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import SDWebImage

extension UIImageView {
    func loadURLWithCdn(url: String) {
        let urlWithCdn = url
        if let url = URL(string: urlWithCdn) {
            sd_setImage(with: url)
        }
    }
    func loadURL(url: String) {
        if let url = URL(string: url) {
            sd_setImage(with: url)
        }
    }
}


