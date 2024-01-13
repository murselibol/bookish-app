//
//  BookService.swift
//  bookish-app
//
//  Created by Mursel Elibol on 11.01.2024.
//

import Foundation

protocol BookServiceProtocol {
    func getBooks(queryItems: [URLQueryItem]?, completion: @escaping (Result<PaginatedResponse<BookResponse>, NetworkError>) -> Void)
    func getBook(id: String, queryItems: [URLQueryItem]?, completion: @escaping (Result<BookResponse, NetworkError>) -> Void)
}

final class BookService: BookServiceProtocol {
    
    static let shared = BookService()
    private init() {}
    
    func getBooks(queryItems: [URLQueryItem]?, completion: @escaping (Result<PaginatedResponse<BookResponse>, NetworkError>) -> Void) {
        let request = BookRequestProvider.getBooks(queryItems: queryItems).request()
         NetworkManager.shared.request(request, completion: completion)
    }
    
    func getBook(id: String, queryItems: [URLQueryItem]?, completion: @escaping (Result<BookResponse, NetworkError>) -> Void) {
         let request = BookRequestProvider.getBook(id: id, queryItems: queryItems).request()
         NetworkManager.shared.request(request, completion: completion)
    }
}
