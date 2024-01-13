//
//  BookRequestProvider.swift
//  bookish-app
//
//  Created by Mursel Elibol on 11.01.2024.
//

import Foundation

enum BookRequestProvider {
    case getBooks(queryItems: [URLQueryItem]?)
    case getBook(id: String, queryItems: [URLQueryItem]?)
}

extension BookRequestProvider: Endpoint {
    var path: String {
        switch self {
        case .getBooks( _):
            return ""
        case .getBook(let id, _):
            return "/\(id)"
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
        case .getBook(_, let queryItems):
            return queryItems
        }
    }

    var body: Encodable? {
        switch self {
        default:
            return nil
        }
    }
}
