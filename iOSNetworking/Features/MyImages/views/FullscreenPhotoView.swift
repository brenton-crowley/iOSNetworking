//
//  FullscreenPhotoView.swift
//  iOSNetworking
//
//  Created by Brent on 4/8/2022.
//

import SwiftUI

struct FullscreenPhotoView: View {
    
    private struct Constants {
        static let progressMessage = "Deleting photo..."
    }
    
    @EnvironmentObject private var model: MyImagesViewModel
    
    @Binding var selectedPhoto:Photo?
    
    @State var showingDeleteAlert = false
    @State var isUpdating = false
    
    let photo:Photo
    
    var viewTitle: String { photo.imageName }
    
    var body: some View {
        
        ZStack {
            NavigationView {
                
                ScrollView([.horizontal, .vertical],
                           showsIndicators: false) {
                    VStack {
                        // TODO: Update to read in image data
                        imageForPhoto(photo)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            deleteButton
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            dismissButton
                        }
                    }
                    .navigationTitle(viewTitle)
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            
            if isUpdating { OverlayProgressView(message: Constants.progressMessage) }
        }
    }
    
    @ViewBuilder
    private func imageForPhoto(_ photo: Photo) -> some View {
        Group {
            if let data = photo.imageData,
               let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
    
    var deleteButton: some View {
    
        Button("Delete") {
            showingDeleteAlert = true
        }
        .alert("Delete Image",
               isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                // TODO: Delete this image from the server
                
                Task {
                    self.isUpdating = true
                    do {
                        try await model.deletePhoto(uuid: photo.imageUuid)
                    } catch {
                        print(error)
                    }
                    
                    self.isUpdating = false
                    selectedPhoto = nil
                }
                
            }
        } message: {
            Text("Deleting an image permanently removes it from the database.")
        }

    }
    
    var dismissButton: some View {
        Button("Cancel") {
            selectedPhoto = nil
        }
    }
}

struct FullscreenPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        
        let photo = Photo.examplePhotos!.first!
        
        FullscreenPhotoView(
            selectedPhoto: Binding.constant(photo),
            photo: photo)
    }
}
