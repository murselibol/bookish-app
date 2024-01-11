//
//  NetworkError.swift
//  bookish-app
//
//  Created by Mursel Elibol on 11.01.2024.
//

import Foundation

enum NetworkError: String, Error  {
    case badUrl
    case unableToCompleteError
    case invalidResponse
    case invalidData
    case authError
    case unknownError
    case decodingError
}
