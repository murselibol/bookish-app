//
//  BookRequestProvider.swift
//  bookish-app
//
//  Created by Mursel Elibol on 11.01.2024.
//

import Foundation

enum BookRequestProvider {
    case getBooks(queryItems: [URLQueryItem]?)
    case getBook(queryItems: [URLQueryItem]?)
}

extension BookRequestProvider: Endpoint {
    var path: String {
        switch self {
        default:
            return ""
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getBooks, .getBook:
            return .get
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .getBooks(let queryItems):
            return queryItems
        case .getBook(let queryItems):
            return queryItems
        }
    }

    var body: Encodable? {
        switch self {
        case .getBooks, .getBook:
            return nil
        }
    }
}
