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
    }
    
    var photos:[Photo]?
    
    var body: some View {
        VStack {
            if let photos = photos {
                EmptyView()
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
    
    var noPhotosFeedback: some View {
        OopsView(
            systemIconImage: Constants.libraryEmptySystemIcon,
            messageText: Constants.libraryEmptyMessage)
    }
    
    var addImageButton: some View {
        Button {
            // TODO
        } label: {
            Image(systemName: "plus")
        }
    }
}

struct MyImagesView_Previews: PreviewProvider {
    static var previews: some View {
        MyImagesView()
    }
}
