//
//  MockBookService.swift
//  bookish-appTests
//
//  Created by Mursel Elibol on 3.02.2024.
//

import Foundation
@testable import bookish_app

final class MockBookService: BookServiceProtocol {
    
    var invokedGetBooksByCategory = false
    var invokedGetBooksByCategoryCount = 0
    var invokedGetBooksByCategoryParameters: (queryItems: [URLQueryItem]?, Void)?
    var invokedGetBooksByCategoryParameterList = [(queryItems: [URLQueryItem]?, Void)]()
    
    func getBooks(queryItems: [URLQueryItem]?, completion: @escaping (Result<bookish_app.PaginatedResponse<bookish_app.BookResponse>, bookish_app.NetworkError>) -> Void) {
        
        invokedGetBooksByCategory = true
        invokedGetBooksByCategoryCount += 1
        invokedGetBooksByCategoryParameters = (queryItems: queryItems, ())
        invokedGetBooksByCategoryParameterList.append((queryItems: queryItems, ()))
        
        let books = MockBookResponse.executeBooks()
        
        let paginatedResponse = PaginatedResponse(kind: "books#list", totalItems: books.count, items: books)
        completion(.success(paginatedResponse))
    }
    
    var invokedGetBook = false
    var invokedGetBookCount = 0
    var invokedGetBookParameters: (queryItems: [URLQueryItem]?, Void)?
    var invokedGetBookParameterList = [(queryItems: [URLQueryItem]?, Void)]()
    
    func getBook(id: String, queryItems: [URLQueryItem]?, completion: @escaping (Result<bookish_app.BookResponse, bookish_app.NetworkError>) -> Void) {
        
        invokedGetBook = false
        invokedGetBookCount += 1
        invokedGetBookParameters = (queryItems: queryItems, ())
        invokedGetBookParameterList.append((queryItems: queryItems, ()))
        
        let book = MockBookResponse.executeBook()
        completion(.success(book))
    }
}
