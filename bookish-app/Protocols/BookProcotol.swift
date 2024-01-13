//
//  BookProcotol.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import Foundation

protocol BookDelegate: AnyObject {
    func onClickBook(id: String)
}