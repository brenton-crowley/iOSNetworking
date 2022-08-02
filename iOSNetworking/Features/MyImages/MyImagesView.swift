//
//  MyImagesView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct MyImagesView: View {
    var body: some View {
        VStack {
            Text("MyImages View")
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
