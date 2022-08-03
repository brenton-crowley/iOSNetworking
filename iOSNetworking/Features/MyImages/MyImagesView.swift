//
//  MyImagesView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct MyImagesView: View {
    
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
        VStack (alignment: .center) {
            Label("Oops!", systemImage: "photo.fill")
                .font(.largeTitle)
                .foregroundColor(.themeAccentLighter)
            Text("You don't have any **images** in your library. Click the **plus button +** in the top right corner add an image.")
                .padding(.horizontal, 20.0)
                .padding(.top, 5.0)
                .multilineTextAlignment(.center)
        }
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
