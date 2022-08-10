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
    
    func performRequest(_ request: Requestable) async throws -> Data? {
        
        let urlRequest = try request.makeURLRequest()
        
        var data:Data?
        
        switch request.requestMethod {
            
        case .POST:
            if let uploadData = urlRequest.httpBody {
                
                let (response, _) = try await self.urlSession.upload(for: urlRequest, from: uploadData)
                data = response
            }
        default:
            let (response, _) = try await self.urlSession.data(for: urlRequest)
            data = response
        }
        
        // could put in a check against the status code here.
        
        return data
    }
    
    func parseJSONData<T: Decodable>(_ data: Data, type: T.Type) throws -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    }
    
}
