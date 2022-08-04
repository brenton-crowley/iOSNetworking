//
//  ContentView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = Tabs.myImages.rawValue
    @State private var isUserProfilePresented = false
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            statusCodesView
            carBrandsView
            myBooksView
            myImagesView
        }
        
    }
    
    var statusCodesView: some View {
        StatusCodesView()
            .nestInNavigationView(selectedTab: selectedTab)
            .tabify(tab: Tabs.statusCodes, selectedTab: $selectedTab)
    }
    
    var carBrandsView: some View {
        CarBrandsView()
            .nestInNavigationView(selectedTab: selectedTab)
            .tabify(tab: Tabs.carBrands, selectedTab: $selectedTab)
    }
    
    var myBooksView: some View {
        MyBooksView()
            .nestInNavigationView(selectedTab: selectedTab)
            .tabify(tab: Tabs.myBooks, selectedTab: $selectedTab)
    }
    
    var myImagesView: some View {
        MyImagesView()
            .nestInNavigationView(selectedTab: selectedTab)
            .tabify(tab: Tabs.myImages, selectedTab: $selectedTab)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

