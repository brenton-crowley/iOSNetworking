//
//  MyBooksView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct MyBooksView: View {
    var body: some View {
        VStack {
            Text("MyBooks View")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                UserProfileButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                addBookButton
            }
        }
    }
    
    var addBookButton: some View {
        Button {
            // TODO
        } label: {
            Image(systemName: "plus")
        }
    }
}

struct MyBooksView_Previews: PreviewProvider {
    static var previews: some View {
        MyBooksView()
    }
}
