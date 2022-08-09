//
//  OverlayProgressView.swift
//  iOSNetworking
//
//  Created by Brent on 9/8/2022.
//

import SwiftUI

struct OverlayProgressView: View {
    
    private struct Constants {
        static let cornerRadius:CGFloat = 10.0
    }
    
    let message: String
    
    var body: some View {
        ZStack {
            Rectangle()
                
                .ignoresSafeArea()
                .foregroundColor(Color.secondary)
            ProgressView(message)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .foregroundColor(Color.themeBackground)
                )
        }
    }
}

struct OverlayProgressView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayProgressView(message: "Updating your book list...")
    }
}
