//
//  CarBrandsView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct CarBrandsView: View {
    
    private struct Constants {
        static let cornerRadius:CGFloat = 15.0
        static let searchBarBGOpacity:CGFloat = 0.2
        static let searchBarBGHeight:CGFloat = 40
        
        static let searchPrompt = "Enter a search query..."
        static let clearSearchSystemImage = "x.circle.fill"
        static let clearSearchButtonPadding:CGFloat = 9
        
        static let isSearchingSystemImage = "magnifyingglass"
        
        static let searchBarOffset:CGFloat = 70
        static let showOpacity:CGFloat = 1
        static let contentOffset:CGFloat = Constants.searchBarOffset - 20.0
    }
    
    @State private var searchText = ""
    @State private var isSearching = true
    
    // TODO: Add list for Car Brands once a request is made.
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                carBrandsList
                    .offset(y: isSearching ? Constants.searchBarOffset : 0)
                    .frame(height: isSearching ? max(geo.size.height - Constants.searchBarOffset, 0) : geo.size.height)
                searchBar
                    .offset(y: isSearching ? 0 : -Constants.contentOffset)
                    .opacity(isSearching ? Constants.showOpacity : 0)
                    .border(.red)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    UserProfileButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    searchItemButton
                        
                }
            }
        .animation(.default, value: isSearching)
        }
    }
    
    var carBrandsList: some View {
        // TODO: Convert to a list and display the car brands
        Color.themeSecondary
    }
    
    var searchBar: some View {
        
        // search bar background
        let background = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color.secondary)
            .opacity(Constants.searchBarBGOpacity)
            .frame(height: Constants.searchBarBGHeight)
        
        // search bar textfield
        let textField = TextField("Search Text", text: $searchText, prompt: Text(Constants.searchPrompt))
            .padding(.horizontal)
        
        // search bar cancel button
        let clearSearchTextButton = Button {
            searchText = ""
        } label: {
            Image(systemName: Constants.clearSearchSystemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal)
                .foregroundColor(.secondary)
        }
        .opacity(searchText.isEmpty ? 0 : Constants.showOpacity)
        .padding(.vertical, Constants.clearSearchButtonPadding)
        
        return HStack {
            ZStack {
                
                background
                
                HStack {
                    textField
                    clearSearchTextButton
                }
            }
            // Button to make API request
            if !searchText.isEmpty { sendSearchQueryButton }
            
            
        }
        .frame(height: Constants.searchBarBGHeight)
        .padding()
        .animation(.default, value: searchText)
        
    }
    
    var sendSearchQueryButton: some View {
        Button("Send") {
            // TODO: Make API request to retrieve car brands.
        }
    }
    
    var searchItemButton: some View {
        Button {
            isSearching.toggle()
        } label: {
            Image(systemName: Constants.isSearchingSystemImage)
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
