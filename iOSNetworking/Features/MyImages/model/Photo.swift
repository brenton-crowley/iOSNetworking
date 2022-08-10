//
//  Photo.swift
//  iOSNetworking
//
//  Created by Brent on 3/8/2022.
//

import Foundation

struct PhotoPage: Decodable {
    var data: [Photo]
}

struct Photo: Identifiable, Decodable, Hashable {
    
    var imageUuid, imageName, imageOriginalFilename, imageFileUrl: String
    var id: String { imageUuid }
    
    var imageData:Data?
    
    var filePath: String {
        let pieces = imageFileUrl.split(separator: "/").suffix(2)
        
        return "/\(pieces.joined(separator: "/"))"
    }
    
}

extension Photo {
    
    static var examplePhotos: [Photo]? {
        
         let photos = [
            
            Photo(imageUuid: UUID().uuidString, imageName: "orange", imageOriginalFilename: "orange.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg"),
            Photo(imageUuid: UUID().uuidString, imageName: "apple", imageOriginalFilename: "apple.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg"),
            Photo(imageUuid: UUID().uuidString, imageName: "banana", imageOriginalFilename: "banana.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg"),
            Photo(imageUuid: UUID().uuidString, imageName: "watermelon", imageOriginalFilename: "watermelon.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg"),
            Photo(imageUuid: UUID().uuidString, imageName: "orange", imageOriginalFilename: "orange.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg"),
            Photo(imageUuid: UUID().uuidString, imageName: "apple", imageOriginalFilename: "banana.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg")
            
        ]
        return photos
    }
    
}
