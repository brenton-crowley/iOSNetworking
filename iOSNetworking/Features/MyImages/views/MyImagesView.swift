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
        static let placeholderSizeRange = 70...Int(maxGridItemSize)
    }
    
    @ObservedObject private var model = MyImagesViewModel()
    
    @State private var isAddingPhotoPresented = false
    @State private var isViewingImage = false
    @State private var selectedPhoto:Photo?
    
    var photos:[Photo]? { model.photos }
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
        .environmentObject(model)
        .task {
            await refreshPhotos()
        }
    }
    
    private func refreshPhotos() async {
        do {
            try await model.refreshImages()
        } catch {
            print(error)
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
//                        Image(photo.imageName)
//                            .resizable()
//                            .scaledToFit()
//                        Text(photo.filePath)
                        photoForImageData(photo.imageData)
                            .task {
                                // fetch image
                                if photo.imageData == nil {
                                    Task {
                                        do {
                                            try await model.fetchImageForFilepath(photo.filePath)
                                        } catch {
                                            print(error)
                                        }
                                    }
                                }
                            }
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
    
    @ViewBuilder
    func photoForImageData(_ imageData: Data?) -> some View {
        
            ZStack {
                
                ProgressView()
                    .opacity(imageData == nil ? 1 : 0)
                    .foregroundColor(.secondary)
                    .frame(width: Constants.maxGridItemSize, height: Constants.maxGridItemSize)
                
                if let data = imageData,
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .opacity(imageData == nil ? 0 : 1)
                }
            }
            .animation(.default, value: imageData)
        
    }

    private func placeholderSize() -> CGSize {
        
        let width = Int(Constants.maxGridItemSize)
        let height = Int.random(in: Constants.placeholderSizeRange)
        
        return CGSize(width: width, height: height)
        
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
        MyImagesView()
            .nestInNavigationView(selectedTab: Tabs.myImages.rawValue)
            .environmentObject(MyImagesViewModel())
    }
}
