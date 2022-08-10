//
//  MyImagesViewModel.swift
//  iOSNetworking
//
//  Created by Brent on 9/8/2022.
//

import Foundation
import UIKit

class MyImagesViewModel: APIViewModel, ObservableObject {
    
    @Published private(set) var photos: [Photo]?
    
    // add an image
    // TODO: Can't do this until the upload works.
    
    // delete an image
    
    func deletePhoto(uuid: String) async throws {
        
        self.photos?.removeAll(where: { $0.imageUuid == uuid })
        
        let _ = try await self.performRequest(DeleteImageRequest(uuid: uuid))
        
//        try await self.refreshImages()
    }
    
    // fetch all images
    // only replace the ones that have not yet been added.
    @MainActor
    func refreshImages() async throws {
        
        if let response = try await self.performRequest(GetAllSavedImagesRequest()),
           let photoPage = try self.parseJSONData(response, type: PhotoPage.self) {

            if let existingPhotos = self.photos {
                self.photos = Array(Set(existingPhotos + photoPage.data))
            } else {
                self.photos = photoPage.data
            }
        }
        
    }
    
    // get a single image
    
    @MainActor
    func fetchImageForFilepath(_ filepath:String ) async throws {
        
        // get the data image
        if let response = try await self.performRequest(GetImageRequest(filePath: filepath)),
           let photoIndex = self.photos?.firstIndex(where: { $0.filePath == filepath }) {
            
            self.photos![photoIndex].imageData = response
            
        }
        
    }
    
}
