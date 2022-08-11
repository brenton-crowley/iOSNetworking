//
//  UserProfileViewModel.swift
//  iOSNetworking
//
//  Created by Brent on 8/8/2022.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    
    @Published private(set) var profile: UserProfile?
    
    @MainActor
    func fetchUserProfile() async throws {
        
        print("Fetch User Profile")
        
        guard let url = makeComponents().url else { throw APIError.invalidURL }
        
        let urlRequest = makeURLRequestFromURL(url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let code = (response as? HTTPURLResponse)?.statusCode
        
        guard code == 200 else { throw APIError.invalidResponseCode(expected: 200, received: code ?? -1) }
        
        self.profile = try parseData(data)
        
    }
    
    private func parseData(_ data: Data) throws -> UserProfile? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(UserProfile.self, from: data)
    }
    
    private func makeComponents() -> URLComponents {
        
        var components = URLComponents()
        components.scheme = APIConstants.scheme
        components.host = APIConstants.host
        components.path = APIConstants.version + "/user"
        
        return components
    }
    
    private func makeURLRequestFromURL(_ url: URL) -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        // set the http headers.
        // add the auth token
        // add the body parameters
        urlRequest.addValue(APIConstants.authToken, forHTTPHeaderField: "Authorization")
        
        return urlRequest
        
    }
}
