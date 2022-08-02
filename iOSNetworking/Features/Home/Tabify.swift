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

extension View {
    
    func tabable(tab:Tabs, selectedTab: Binding<Int>) -> some View {
        self.modifier(Tabify(tab: tab, selectedTab: selectedTab))
    }
    
}
