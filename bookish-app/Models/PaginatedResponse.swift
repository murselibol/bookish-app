//
//  PaginatedResponse.swift
//  bookish-app
//
//  Created by Mursel Elibol on 11.01.2024.
//

import Foundation

struct PaginatedResponse<T:Codable>: Codable {
    let kind: String?
    let totalItems: Int?
    let items: [T]?
}
