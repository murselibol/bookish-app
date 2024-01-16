//
//  HomeSectionType.swift
//  bookish-app
//
//  Created by Mursel Elibol on 12.01.2024.
//

import Foundation

enum HomeSectionType: Int {
    case popular
    case category
    case book
    case rising
    case discover
    
    var sectionTitle: String {
        switch self {
        case .popular: 
            return "Popular 🔥"
        case .book: 
            return "Book of the Week ✨"
        case .rising: 
            return "Rising 🚀"
        case .discover: 
            return "Discover 🔎"
        default: 
            return "Book"
        }
    }
    
    var sectionCategory: CategoryType {
        switch self {
        case .popular: 
            return .history
        case .category: 
            return .fantasy
        case .rising: 
            return .love
        case .discover: 
            return .philosophy
        default: 
            return .fantasy
        }
    }
}
