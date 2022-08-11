//
//  APIViewModel.swift
//  iOSNetworking
//
//  Created by Brent on 8/8/2022.
//

import Foundation

class APIViewModel {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func performRequest(_ request: Requestable, expectedResponseCode: Int = 200, printResponse: Bool  = false) async throws -> Data? {
        
        let urlRequest = try request.makeURLRequest()
        
        var (data, response): (Data, URLResponse)
        
        if let _ = request.formData,
           let uploadData = urlRequest.httpBody {
            
            (data, response) = try await self.urlSession.upload(for: urlRequest, from: uploadData)
            
        } else {
            (data, response) = try await self.urlSession.data(for: urlRequest)
        }
        
        // Check that the status code is the expected response.
        let code = (response as? HTTPURLResponse)?.statusCode
        guard code == expectedResponseCode else { throw APIError.invalidResponseCode(expected: expectedResponseCode, received: code ?? -1) }
        
        return data
    }
    
    func parseJSONData<T: Decodable>(_ data: Data, type: T.Type) throws -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    }
    
}
