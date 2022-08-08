//
//  GetCarBrandsWithQueryRequest.swift
//  iOSNetworking
//
//  Created by Brent on 8/8/2022.
//

import Foundation

// Now all we need to do is create a request that conforms to Requestable protocol. The creation of the request is largely taken care of so that we don't need to copy and paste code from request to request.

struct GetCarBrandsWithQueryRequest: Requestable {
    
    var path: String = "/car-brands"
    var queryParams: [String : String?] = [:] // if we want to override default implementation, then we must re-declare.
    
    init(_ userQuery: String?, page: Int? = nil) {
        
        self.queryParams["q"] = userQuery
        self.queryParams["page"] = page != nil ? String(page!) : nil
        
    }
}
