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
    static let authToken = "Bearer 4|tBEodH7QmM2g5lLWDTots0ZqYS1Mzkz0KMeOJoSx"
}

enum APIError: Error {
    
    case invalidURL, invalidResponseCode, invalidData
    
}
