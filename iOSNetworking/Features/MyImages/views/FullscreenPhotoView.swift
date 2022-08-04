//
//  FullscreenPhotoView.swift
//  iOSNetworking
//
//  Created by Brent on 4/8/2022.
//

import SwiftUI

struct FullscreenPhotoView: View {
    
    private struct Constants {
        
    }
    
    @Binding var isPresented:Bool
    
    @State var showingDeleteAlert = false
    
    let photo:Photo
    
    var viewTitle: String { photo.imageName }
    
    var body: some View {
        NavigationView {
            
            ScrollView([.horizontal, .vertical],
                       showsIndicators: false) {
                VStack {
                    // TODO: Update to read in image data
                    Image(photo.imageName)
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
    }
    
    var deleteButton: some View {
    
        Button("Delete") {
            // TODO: Send request to upload the image
            showingDeleteAlert = true
        }
        .alert("Delete Image",
               isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                // TODO: Delete this image from the server
                isPresented = false
            }
        } message: {
            Text("Deleting an image permanently removes it from the database.")
        }

    }
    
    var dismissButton: some View {
        Button("Cancel") {
            isPresented = false
        }
    }
}

struct FullscreenPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        FullscreenPhotoView(
            isPresented: Binding.constant(false),
            photo: Photo.examplePhotos!.last!)
    }
}
