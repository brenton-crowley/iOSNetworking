//
//  CarBrandRow.swift
//  iOSNetworking
//
//  Created by Brent on 4/8/2022.
//

import SwiftUI

struct CarBrandRow: View {
    
    private struct Constants {
        static let rowHeight:CGFloat = 100.0
        
        // ranking
        static let rankingCircleWidth:CGFloat = 75.0
        static let rankingBgOpacity:CGFloat = 0.5
        
        // Details
        static let detailItemSpacing:CGFloat = 10.0
    }
    
    // MARK: - View
    
    let carBrand: CarBrand
    
    var placeholderColors:[Color] {
        let colors:[Color] = [
            .themeAccentDark,
            .themeSecondary,
            .themeTertiary
        ]
        
        return colors
    }
    
    var body: some View {
        HStack {
            ranking
            // details
            brandDetails
        }
        .frame(height: Constants.rowHeight)
    }
    
    // MARK: - Book Details
    
    var brandDetails: some View {
        
        VStack (alignment: .leading) {
            
            Group {
                Text(carBrand.name)
                    .font(.title)
                    .padding(.bottom, 1)
                Text(carBrand.origin)
                    .font(.callout)
                    .foregroundColor(.secondary)
                Text(carBrand.segment)
                    .font(.caption)
//                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
                
            // Title
            HStack { Spacer() }
        }
    }
    
    @ViewBuilder
    private func detailField(_ labelText: String, systemIconImage: String, value: String) -> some View {
        HStack {
            Label(labelText, systemImage: systemIconImage)
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
    }
    
    // MARK: - Ranking
    
    var ranking: some View {
        
        // background
        ZStack {
            
            let colorIndex = Int.random(in: 0..<placeholderColors.count)
            let bgColor = placeholderColors[colorIndex]
            
            Circle()
                .fill(bgColor)
                .frame(width: Constants.rankingCircleWidth)
                .opacity(Constants.rankingBgOpacity)
                .overlay(
                    Circle()
                        .stroke(bgColor)
                )
            
            Text(carBrand.rank)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .blendMode(.overlay)
        }
    }
}

struct CarBrandRow_Previews: PreviewProvider {
    static var previews: some View {
        CarBrandRow(carBrand: CarBrand.example)
//            .preferredColorScheme(.dark)
    }
}
