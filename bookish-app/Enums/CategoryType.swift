//
//  Category.swift
//  bookish-app
//
//  Created by Mursel Elibol on 12.01.2024.
//

import Foundation

enum CategoryType {
    case love
    case history
    case philosophy
    case art
    case fantasy
    case crime
    case biography
    case mythology
    case scienceFiction
    case psychology
    
    var title: String {
        switch self {
        case .love:
            "Love"
        case .history:
            "History"
        case .philosophy:
            "Philosophy"
        case .art:
            "Art"
        case .fantasy:
            "Fantasy"
        case .crime:
            "Crime"
        case .biography:
            "Biography"
        case .mythology:
            "Mythology"
        case .scienceFiction:
            "Science Fiction"
        case .psychology:
            "Psychology"
        }
    }
}
