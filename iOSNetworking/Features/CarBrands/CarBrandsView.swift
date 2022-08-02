//
//  CarBrandsView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct CarBrandsView: View {
    
    public var isSearching = false
    
    var body: some View {
        VStack {
            Text("Car Brands View")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                UserProfileButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                searchItemButton
            }
        }
    }
    
    var searchItemButton: some View {
        Button {
            // TODO
        } label: {
            Image(systemName: "magnifyingglass")
        }
    }
}

struct CarBrandsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CarBrandsView()
        }
    }
}
