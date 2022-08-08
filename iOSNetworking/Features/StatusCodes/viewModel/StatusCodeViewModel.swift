//
//  StatusCodeViewModel.swift
//  iOSNetworking
//
//  Created by Brent on 5/8/2022.
//

import Foundation
import AVFoundation

class StatusCodeViewModel: ObservableObject {
    
    @Published private(set) var statusCodes: [String: StatusCode]
    @Published private(set) var isFetching: Bool = false
    
    
    init(){
        statusCodes = [:]
    }
    
    func fetchStatusCode(_ statusCode: String) {
        
        // we need the endpoint: https://learnrest.dev/api/v1/status/:code
        
        /// 1. We need to convert the endpoint into a usable url.
        /// To do that, we'll use URLComponents
        /// https://www.swiftbysundell.com/articles/constructing-urls-in-swift/
        
        var components = URLComponents()
        components.scheme = "https" // http version
        components.host = "learnrest.dev" // api
        components.path = "/api/v1" + "/status" + "/\(statusCode)" // version of the api + the endpoint path + path parameters
        
        /// 1b. Add any query parameters
        /// These will be a dictionary of [String: String?] where the key is the parameter name and the value is the value of the parameter.
        /// We'll map this dictionary to a URLQueryItem(name: key, value: value)
        /// But since status code doesn't have any query parameters, we'll skip this step for now.
        ///
        /// let queryParams: [String: String?] = [:]
        /// queryParams.map { URLQueryItem(name: $0, value: $1) }
        
        /// 2. Reference the URL of the components and make a URLRequest
        /// We'll want to:
        /// a) set any headers
        /// b) set the bearer token for authorization.
        /// c) set any body parameters
        ///
        guard let url = components.url else { return }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        // set the http headers.
        // add the auth token
        // add the body parameters
        urlRequest.allHTTPHeaderFields = [:]
        let token = "Bearer 4|tBEodH7QmM2g5lLWDTots0ZqYS1Mzkz0KMeOJoSx"
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization") // Can't add header like this as it's reserved. Refer to docs.
            
        /// 3. Use URLSession.share to initiate a dataTask.
        /// 3a. Pass in the urlRequest that was created.
        /// Optionally create a completion handler as a call back
        /// Break this out into a function with a completion handler.
        
        isFetching = true
        print("Request: \(urlRequest)")
        
        let task = URLSession.shared.dataTask(
            with: urlRequest) { data, response, error in
                
                DispatchQueue.main.async { self.isFetching = false }
                
                guard error == nil else { return }
                
//                guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
                
                if let data = data {
                    
                    print("Data: \(String(data: data, encoding: .utf8)!)")
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    do {
                        var result = try decoder.decode(StatusCode.self, from: data)
                        result.status = statusCode
                        
                        DispatchQueue.main.async { self.statusCodes[statusCode] = result }
                        
                        
                    } catch {
                        print(error)
                    }
                    
                }
                
            }
        
        task.resume()
    }
}
