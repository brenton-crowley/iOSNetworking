//
//  Tabs.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import Foundation

enum Tabs: Int, CaseIterable {
    
    case statusCodes, carBrands, myBooks, myImages
    
    var title: String {
        
        var title = ""
        
        switch self {
        case .statusCodes:
            title = "Status Codes"
        case .carBrands:
            title = "Car Brands"
        case .myBooks:
            title = "My Books"
        case .myImages:
            title = "My Images"
        }
        
        return title
    }
    
    var symbol: String {
        
        var symbol: String
        
        switch self {
        case .statusCodes:
            symbol = "chevron.left.forwardslash.chevron.right"
        case .carBrands:
            symbol = "car"
        case .myBooks:
            symbol = "book"
        case .myImages:
            symbol = "photo"
        }
        
        return symbol
    }
    
}
