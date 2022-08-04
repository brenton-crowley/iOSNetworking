//
//  OopsView.swift
//  iOSNetworking
//
//  Created by Brent on 4/8/2022.
//

import SwiftUI

struct OopsView: View {
    
    private struct Constants {
        static let horizontalPadding:CGFloat = 20.0
        static let verticalPadding:CGFloat = 5.0
    }
    
    var labelText: String = "Oops!"
    let systemIconImage: String
    let messageText: String
    
    var body: some View {
        VStack (alignment: .center) {
            Label(labelText,
                  systemImage: systemIconImage)
                .font(.largeTitle)
                .foregroundColor(.themeAccentLighter)
            Text(messageText)
                .padding(.horizontal, Constants.horizontalPadding)
                .padding(.top, Constants.verticalPadding)
                .multilineTextAlignment(.center)
        }
    }
}

struct OopsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let message = "You don't have any books in your library. Click the plus button + in the top right corner add a book."
        
        OopsView(
            systemIconImage: "photo.fill",
            messageText: message)
    }
}
