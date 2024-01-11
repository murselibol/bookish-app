//
//  BookService.swift
//  bookish-app
//
//  Created by Mursel Elibol on 11.01.2024.
//

import Foundation

protocol BookServiceProtocol {
    func getBooks(queryItems: [String: String], completion: @escaping (Result<PaginatedResponse<BookResponse>, NetworkError>) -> Void)
}

final class BookService: BookServiceProtocol {
    
    static let shared = BookService()
    private init() {}
    
    func getBooks(queryItems: [String: String] = [:], completion: @escaping (Result<PaginatedResponse<BookResponse>, NetworkError>) -> Void) {
         let request = BookRequestProvider.books(queryItems: queryItems).request()
            print(request)
         NetworkManager.shared.request(request, completion: completion)
    }
    
}
