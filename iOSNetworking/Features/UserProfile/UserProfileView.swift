//
//  UserProfileView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct UserProfileView: View {
    
    @Binding var isPresented:Bool
    
    private struct Constants {
        static let dismissSystemImage = "x.circle.fill"
        static let dismissButtonHeight:CGFloat = 25.0
        
        static let profileImageHeight:CGFloat = 0.37 // percentage value
        static let profileImageBorderWidth:CGFloat = 3.0
        static let profileImageBorderPadding:CGFloat = -5
        static let profileImageBorderOpacity:CGFloat = 0.4
        static let profileImagePlaceholderImageName = "user-profile-placeholder"
        
        static let emailListTitle = "Email"
        static let emailListSystemImage = "mail"
        
        static let timezoneListTitle = "Timezone"
        static let timezoneSystemImage = "clock"
        
    }
    
    var body: some View {
        
            VStack(alignment: .center) {

                    header
                    placeholderImage
                        .padding(.bottom)
                    profileDetails
                }
        
    }
    
    var header: some View {
        
        ZStack (alignment: .center)  {
            Text("User Profile") // TODO: Make dynamic based
                .font(.system(.title2).weight(.medium))
                .multilineTextAlignment(.center)
            HStack {
                Spacer()
                dismissButton
                    .frame(height: Constants.dismissButtonHeight)
            }
        }
        .padding()
        
        
    }
    
    var profileDetails: some View {
        List {
            
            listItemWithTitle(Constants.emailListTitle,
                              systemImage: Constants.emailListSystemImage,
                              text: "todo@todo.com") // TODO: Make dynamic
            
            listItemWithTitle(Constants.timezoneListTitle,
                              systemImage: Constants.timezoneSystemImage,
                              text: "todo")
        }
    }
    
    @ViewBuilder
    private func listItemWithTitle(_ title: String, systemImage: String, text: String) -> some View {
        
        HStack {
            Label("\(title): ", systemImage: systemImage)
            Spacer()
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal)
        }
        
    }
    
    var placeholderImage: some View {
        
        Image(Constants.profileImagePlaceholderImageName)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.secondary, lineWidth: Constants.profileImageBorderWidth)
                        .padding(Constants.profileImageBorderPadding)
                        .opacity(Constants.profileImageBorderOpacity)
                )
    }
    
    var dismissButton: some View {
        
        Button {
            isPresented = false
        } label: {
            Image(systemName: Constants.dismissSystemImage)
                .resizable()
                .scaledToFit()
        }
        
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(isPresented: Binding.constant(true))
    }
}
