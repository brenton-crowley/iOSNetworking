//
//  UserProfileButton.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct UserProfileButton: View {
    
    @State private var isPresented = false
    
    var body: some View {
        Button {
            isPresented = true
        } label: {
            Image(systemName: Tabs.userProfile.symbol)
        }
        .sheet(isPresented: $isPresented) {
            // Present UserProfileView once created.
            Color.red
                .ignoresSafeArea()
        }
    }
}

struct UserProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileButton()
    }
}
