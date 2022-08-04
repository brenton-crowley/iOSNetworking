//
//  MyImagesView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct MyImagesView: View {
    
    private struct Constants {
        // Empty libary
        static let libraryEmptyMessage = "You don't have any images in your library. Click the plus button + in the top right corner to add an image."
        static let libraryEmptySystemIcon = "photo.fill"
        
        static let maxGridItemSize:CGFloat = 100.0
    }
    
    @State private var isAddingPhotoPresented = false
    @State private var isViewingImage = false
    @State private var selectedPhoto:Photo?
    
    var photos:[Photo]?
    var columns: [GridItem] {
        Array(repeating: .init(.flexible(maximum: Constants.maxGridItemSize)), count: 3)
    }
    
    var body: some View {
        VStack {
            if let photos = photos {
                photosView(photos: photos)
            } else {
                noPhotosFeedback
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                UserProfileButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                addImageButton
            }
        }
    }
    
    // MARK: - PhotosView
    
    @ViewBuilder
    private func photosView(photos: [Photo]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(photos) { photo in
                    
                    Button {
                        selectedPhoto = photo
                        isViewingImage = true
                    } label: {
                        Image(photo.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .sheet(item: $selectedPhoto) { photo in

                    FullscreenPhotoView(
                        selectedPhoto: $selectedPhoto,
                        photo: photo)
                }
            }
        }
    }

    // MARK: - No Photos View
    
    var noPhotosFeedback: some View {
        OopsView(
            systemIconImage: Constants.libraryEmptySystemIcon,
            messageText: Constants.libraryEmptyMessage)
    }
    
    // MARK: - Toolbar Buttons
    
    var addImageButton: some View {
        Button {
            // TODO
            isAddingPhotoPresented = true
        } label: {
            Image(systemName: "plus")
        }
        .sheet(isPresented: $isAddingPhotoPresented) {
            AddPhotoView(isPresented: $isAddingPhotoPresented)
        }
    }
}

struct MyImagesView_Previews: PreviewProvider {
    static var previews: some View {
        MyImagesView(photos: Photo.examplePhotos)
            .nestInNavigationView(selectedTab: Tabs.myImages.rawValue)
    }
}
