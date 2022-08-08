//
//  iOSNetworkingApp.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

@main
struct iOSNetworkingApp: App {
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(UserProfileViewModel())
        }
    }
}
