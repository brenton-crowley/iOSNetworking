//
//  BookRequests.swift
//  iOSNetworking
//
//  Created by Brent on 9/8/2022.
//

import Foundation

// look to the documentation to see what you need to create

class BaseBookRequest: Requestable {
    
    var path: String = "/books"
    var requestMethod: RequestMethod = .GET
    var queryParams: [String : String?] = [:]
    
    fileprivate init() {}
    
    struct BookDetails {
        
        var queryParams: [String : String?] = [:]
    
        init(title: String, author: String, isbn: String?, publisher: String?, publishedAt: String?, description: String?) {
            
            queryParams["title"] = title
            queryParams["author"] = author
            queryParams["isbn"] = isbn
            queryParams["publisher"] = publisher
            queryParams["published_at"] = publishedAt
            queryParams["description"] = description
            
        }
    }
}

class GetAllSavedBooksRequest: BaseBookRequest {
    
    override init() { super.init() }
}

class SaveBookRequest: BaseBookRequest {
    
    init(bookDetails: BaseBookRequest.BookDetails) {
        
        super.init()
        
        self.queryParams = bookDetails.queryParams

        self.requestMethod = .POST
        
    }
}

class UpdateBookRequest: BaseBookRequest {
    
    init(uuid: String, bookDetails: BaseBookRequest.BookDetails) {
        
        super.init()
        
        self.queryParams = bookDetails.queryParams
        self.path += "/\(uuid)"
        
        self.requestMethod = .PUT
        
    }
}

// will not implement this in the demo. We'll implement delete in the images demo.
class DeleteBookRequest: BaseBookRequest {
    
    init(uuid: String) {
        super.init()
        self.path += "/\(uuid)"
        self.requestMethod = .DELETE
    }
    
}
