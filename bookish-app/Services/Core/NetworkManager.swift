//
//  NetworkManager.swift
//  bookish-app
//
//  Created by Mursel Elibol on 11.01.2024.
//

import Foundation



protocol NetworkManagerProtocol {
    func request<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {

    static let shared = NetworkManager()
    private init(){ }
    
    func request<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                completion(.failure(.unableToCompleteError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
            case 401:
                completion(.failure(.authError))
            default:
                completion(.failure(.unknownError))
            }

        }
        task.resume()
        
    }
}
