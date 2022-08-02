//
//  Tabify.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import Foundation
import SwiftUI

struct Tabify: ViewModifier {
    
    var tab:Tabs
    
    @Binding var selectedTab: Int
    
    func body(content: Content) -> some View {
        content
            .tabItem {
                
                Text(tab.title)
                Image(systemName: tab.symbol)
            }
            .tag(tab.rawValue)
    }
    
}

struct NestInNavigationView: ViewModifier {
    
    let selectedTab: Int
    
    var tab: Tabs? { Tabs.init(rawValue: selectedTab) }
    
    
    func body(content: Content) -> some View {
        
        NavigationView {
            content
                .navigationTitle(tab?.title ?? "")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

extension View {
    
    func tabify(tab:Tabs, selectedTab: Binding<Int>) -> some View {
        self.modifier(Tabify(tab: tab, selectedTab: selectedTab))
    }
    
    func nestInNavigationView(selectedTab: Int) -> some View {
        self.modifier(NestInNavigationView(selectedTab: selectedTab))
    }
    
}
