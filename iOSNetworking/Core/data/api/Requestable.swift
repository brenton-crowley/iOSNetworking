//
//  Requestable.swift
//  iOSNetworking
//
//  Created by Brent on 8/8/2022.
//

import Foundation

/// Building out this protocol will be a single lesson.
/// Have the side-by-side comparison.

enum RequestMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

protocol Requestable {
    
    // URLComponents
    var scheme: String { get }
    var host: String { get }
    var version: String { get }
    var path: String { get }
    
    // Headers
    var headers: [String: String] { get }
    
    // Query Paramerters
    var queryParams: [String: String?] { get }
    
    // Body Parameters
    var bodyParams: [String: Any] { get }
    var formData: MultipartFormdata? { get }
    
    // HTTP Method
    var requestMethod: RequestMethod { get }
}

// default implementation
extension Requestable {
    
    static var boundaryKey: String { "boundary" }
    
    // url
    var scheme: String { APIConstants.scheme }
    var host: String { APIConstants.host }
    var version: String { APIConstants.version }
    var requestMethod: RequestMethod { .GET }
    
    // parameters
    var headers: [String: String] { [:] }
    var queryParams: [String: String?] { [:] }
    var bodyParams: [String: Any] { [:] }
    var formData: MultipartFormdata? { nil }
    
    // authorization
    var addAuthorizationToken: Bool { true }
    var token: String { APIConstants.authToken }
    
    func makeURLRequest() throws -> URLRequest {
        
        guard let url = makeURLComponents().url else { throw APIError.invalidURL}
        
        var urlRequest = URLRequest(url: url)
        
        // set the HTTP Methods
        urlRequest.httpMethod = requestMethod.rawValue
        
        // add the headers
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        // add the auth token
        if addAuthorizationToken {
            urlRequest.setValue(APIConstants.authToken, forHTTPHeaderField: "Authorization")
        }
        
        // skip the body params.
        if let form = formData {
            urlRequest.httpBody = form.httpBody
        }
        
        return urlRequest
    }
    
    private func makeURLComponents() -> URLComponents {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = version + path // we'll set the path in a URL Request.
        
        // add any query parameters.
        if !queryParams.isEmpty {
            components.queryItems = queryParams.map { URLQueryItem(name: $0, value: $1)}
        }
        
        return components
    }
    
    
}
