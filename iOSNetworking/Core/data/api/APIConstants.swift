//
//  APIConstants.swift
//  iOSNetworking
//
//  Created by Brent on 8/8/2022.
//

import Foundation

struct APIConstants {
    
    // URL Construction
    static let scheme: String = "https"
    static let host: String = "learnrest.dev"
    static let version: String = "/api/v1"
    
    // Headers
    static let authToken = "Bearer 8|yfCrZddj5kWV06l0JsNdBHpnO79pIUW059vnSYzI"
}

enum APIError: Error {
    
    case invalidURL, invalidResponseCode(expected: Int, received: Int), invalidData
    
}
