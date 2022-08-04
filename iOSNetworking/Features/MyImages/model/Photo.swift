//
//  Photo.swift
//  iOSNetworking
//
//  Created by Brent on 3/8/2022.
//

import Foundation

struct Photo: Identifiable, Decodable {
    
    var uuid, imageName, imageOriginalFilename, imageFileUrl: String
    var id: String { uuid }
    
    var filePath: String { "" } // TODO: Split the imageFileUrl from the date/imagename.jpeg
    
}

extension Photo {
    
    static var examplePhotos: [Photo]? {
        
         let photos = [
            
            Photo(uuid: UUID().uuidString, imageName: "orange", imageOriginalFilename: "orange.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg"),
            Photo(uuid: UUID().uuidString, imageName: "apple", imageOriginalFilename: "apple.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg"),
            Photo(uuid: UUID().uuidString, imageName: "banana", imageOriginalFilename: "banana.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg"),
            Photo(uuid: UUID().uuidString, imageName: "watermelon", imageOriginalFilename: "watermelon.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg"),
            Photo(uuid: UUID().uuidString, imageName: "orange", imageOriginalFilename: "orange.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg"),
            Photo(uuid: UUID().uuidString, imageName: "apple", imageOriginalFilename: "banana.jpeg", imageFileUrl: "https://learnrest.dev/api/v1/images/202208/7ninRWFxjVpBz9f.jpeg")
            
        ]
        return photos
    }
    
}
