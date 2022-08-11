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
    static let authToken = "Bearer 6|Qzveq6vI9p0Bev7y2ygDL497Fkth9i1QddTnSyH7"
}

enum APIError: Error {
    
    case invalidURL, invalidResponseCode(expected: Int, received: Int), invalidData
    
}
