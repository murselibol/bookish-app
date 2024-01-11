//
//  BookRequestProvider.swift
//  bookish-app
//
//  Created by Mursel Elibol on 11.01.2024.
//

import Foundation

enum BookRequestProvider {
    case books(queryItems: [URLQueryItem])
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
        case .books:
            return .get
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .books(let queryItems):
            return queryItems
        }
    }

    var body: Encodable? {
        switch self {
        case .books:
            return nil
        }
    }
}
