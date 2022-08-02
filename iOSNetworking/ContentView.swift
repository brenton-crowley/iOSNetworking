//
//  ContentView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = Tabs.statusCodes.rawValue
    @State private var isUserProfilePresented = false
    
    var body: some View {
        
        tabView
        
    }
    
    var tabView: some View {
        
        NavigationView {
            
            let focussedTab = Tabs.init(rawValue: selectedTab)
            
            TabView {
                statusCodesView
                carBrandsView
                myBooksView
                myImagesView
            }
            .navigationTitle(focussedTab?.title ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    userProfileItem
                }
            }
            
        }
        
    }
    
    var statusCodesView: some View {
        Text(Tabs.statusCodes.title)
            .tabify(tab: Tabs.statusCodes, selectedTab: $selectedTab)
    }
    
    var carBrandsView: some View {
        Text(Tabs.carBrands.title)
            .tabify(tab: Tabs.carBrands, selectedTab: $selectedTab)
    }
    
    var myBooksView: some View {
        Text(Tabs.myBooks.title)
            .tabify(tab: Tabs.myBooks, selectedTab: $selectedTab)
    }
    
    var myImagesView: some View {
        Text(Tabs.myImages.title)
            .tabify(tab: Tabs.myImages, selectedTab: $selectedTab)
    }
    
    var userProfileItem: some View {
        Button {
            isUserProfilePresented = true
        } label: {
            Image(systemName: Tabs.userProfile.symbol)
        }
        .sheet(isPresented: $isUserProfilePresented) {
            // change to user profile view
            Color.themeBackground
                .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

