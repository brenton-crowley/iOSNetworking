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
    func uploadImage(_ image: UIImage, fileName: String) async throws {
        
        let image = image.aspectFittedToHeight(500.0)
        
        if let imageData = image.jpegData(compressionQuality: 0) {
            
            let fields = [
                MultipartFormdata.FieldType.file(
                    fieldName: "image", // docs name
                    value: imageData,
                    fileName: "\(fileName).jpeg",
                    mimeType: "image/jpeg"),
                MultipartFormdata.FieldType.text(
                    fieldName: "image_name", // docs name
                    value: fileName)
            ]
            
            let request =  UploadImageRequest(formData: MultipartFormdata(fields: fields))
            
            let _ = try await self.performRequest(request)
            
            try await self.refreshImages()
        }
    }
    
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
                
                for newPhoto in photoPage.data {
                    
                    if !(existingPhotos.contains(where: { $0.imageUuid == newPhoto.imageUuid })) {
                        self.photos?.append(newPhoto)
                    }
                    
                }
                
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

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
