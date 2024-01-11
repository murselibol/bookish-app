//
//  Environment.swift
//  bookish-app
//
//  Created by Mursel Elibol on 11.01.2024.
//

import Foundation

enum Environment {
    private static let infoDict: [String:Any] = {
        guard let dic = Bundle.main.infoDictionary else {  
            fatalError("plist is not found")
        }
        return dic
    }()
    
        
    static let baseURL: String = {
        guard let urlString = Self.infoDict["BASE_URL"] as? String else {
            fatalError("BASE_URL is not found")
        }
        return "https://"+urlString
    }()
    
    static let apiKey: String = {
        guard let apiKey = Self.infoDict["API_KEY"] as? String else {
            fatalError("API_KEY is not found")
        }
        return apiKey
    }()
}
