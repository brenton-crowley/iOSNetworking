//
//  ImageRequests.swift
//  iOSNetworking
//
//  Created by Brent on 9/8/2022.
//

import Foundation

class ImageRequest: Requestable {
    
    var path: String = "/images"
    var queryParams: [String : String?] = [:]
    var requestMethod: RequestMethod = .GET
    var formData: MultipartFormdata? = nil
    var headers: [String : String] = [:]
    
    fileprivate init() { }
}

class GetAllSavedImagesRequest: ImageRequest {
    
    override init() {
        super.init()
    }
    
}

class GetImageRequest: ImageRequest {
    
    init(filePath: String) {
        
        super.init()
        
        self.path += filePath
    }
    
}

class DeleteImageRequest: ImageRequest {
    
    init(uuid: String) {
        super.init()
        
        self.path += "/\(uuid)" // path parameter
        
        self.requestMethod = .DELETE
    }
    
}

class UploadImageRequest: ImageRequest {
    
    init(formData: MultipartFormdata) {
        super.init()
        self.formData = formData
        self.requestMethod = .POST
        
        if let headerValue = self.formData?.headerValue { self.headers["Content-Type"] = headerValue }
        
    }
    
}
