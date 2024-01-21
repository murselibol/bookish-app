//
//  BookProcotol.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import Foundation

protocol BookClickListener: AnyObject {
    func onClickBook(id: String)
}

protocol AuthorClickListener: AnyObject {
    func onClickAuthor(authorName: String)
}

