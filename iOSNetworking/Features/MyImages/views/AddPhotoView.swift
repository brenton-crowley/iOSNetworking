//
//  AddPhotoView.swift
//  iOSNetworking
//
//  Created by Brent on 4/8/2022.
//

import SwiftUI

struct AddPhotoView: View {
    
    private struct Constants {
        
        static let viewTitle = "Add an Image"
        
        static let imageHeight:CGFloat = 250.0
        static let imageOpacity:CGFloat = 0.5
    }
    
    @Binding var isPresented: Bool
    
    @State private var showingImagePicker = false
    @State private var inputImageName = ""
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    var isUserActionDisabled:Bool { image == nil ? true : false }
    
    var textfieldPrompt: String {
        if isUserActionDisabled {
            return "Choose an image to edit the name."
        }
        
        return "Must have an image name."
    }
    
    var body: some View {
        NavigationView {
            VStack {
                photoView
                    .frame(height: Constants.imageHeight)
                    .onTapGesture {
                        showingImagePicker = true
                    }
//                chooseImageButtons
                imageNameTextfield
                Spacer()
            }
            .navigationTitle(Constants.viewTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage, imageName: $inputImageName)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    dismissButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    uploadButton
                }
            }
        }
    }
    
    var imageNameTextfield: some View {
        
        VStack (alignment: .leading) {
            Label("What's the name of this image?", systemImage: "photo")
                .foregroundColor(.secondary)
                .font(.headline)
            TextField(textfieldPrompt, text: $inputImageName)
                .textFieldStyle(.roundedBorder)
                .disabled(isUserActionDisabled)
        }
        .padding()
        
    }
    
    var photoView: some View {
        ZStack {
            
                
            Rectangle()
                .frame(height: Constants.imageHeight)
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: Constants.imageHeight)
                    .background(
                    )
            } else {
                Text("Tap to choose an image.")
                    .foregroundColor(.themeBackground)
            }
        }
    }
    
    var chooseImageButtons: some View {
        VStack {
            Text("Choose from...")
                .padding()
            HStack {
                //                Spacer()
                chooseImageButtonType(
                    source: .photoLibrary,
                    labelText: "Library",
                    systemImageIcon: "photo")
                //                Spacer()
                //                chooseImageButtonType(
                //                    source: .camera,
                //                    labelText: "Camera",
                //                    systemImageIcon: "camera")
                //                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func chooseImageButtonType(
        source:UIImagePickerController.SourceType,
        labelText: String,
        systemImageIcon: String) -> some View {
            
            Button {
                // Activate controller
                showingImagePicker = true
            } label: {
                Label(labelText, systemImage: systemImageIcon)
            }
            
        }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
    }
    
    var uploadButton: some View {
    
        Button("Upload") {
            // TODO: Send request to upload the image
        }
        .disabled(isUserActionDisabled || inputImageName.isEmpty)
        
    }
    
    var dismissButton: some View {
        Button("Cancel") {
            isPresented = false
        }
    }
}

struct AddImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotoView(isPresented: Binding.constant(false))
    }
}
