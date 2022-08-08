//
//  CarBrandsViewModel.swift
//  iOSNetworking
//
//  Created by Brent on 8/8/2022.
//

import Foundation

class CarBrandsViewModel: APIViewModel, ObservableObject {
    
    @Published private(set) var brands: [CarBrand]?
    @Published private(set) var hasMoreBrands: Bool = true
    
    private(set) var page: Int = 1
    
    // Pause here. Build a super class.
    // Build the Requestable protocol.
    @MainActor
    func fetchCarBrandsWithQuery(_ query: String, page: Int = 1) async throws {
        
        if let response = try await self.performRequest(
            GetCarBrandsWithQueryRequest(
                query.lowercased() == "all" ? nil : query,
                page: page)) {
            
            print("Page number: \(page)")
            
            if let carPage = try self.parseJSONData(response, type: CarPage.self) {
                
                if page == 1 {
                    self.brands = carPage.data
                    self.page = 1
                } else {
                    if let _ = self.brands {
                        self.brands! += carPage.data
                    }
                }
                
                hasMoreBrands = !carPage.data.isEmpty
            }
            
            
        } else {
            throw APIError.invalidData
        }
    }
    
    func fetchMoreBrandsWithQuery(_ query: String) async throws {
        
        page += 1
        try await fetchCarBrandsWithQuery(query, page: page)
        
    }
}
