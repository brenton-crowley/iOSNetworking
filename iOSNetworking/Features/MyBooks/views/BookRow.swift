//
//  BookRow.swift
//  iOSNetworking
//
//  Created by Brent on 3/8/2022.
//

import SwiftUI

struct BookRow: View {
    
    private struct Constants {
        static let rowHeight:CGFloat = 100.0
        
        // placerholderCover
        static let placeholderCornerRadius:CGFloat = 5.0
        static let bookCoverWidth:CGFloat = 80.0
        
        // Details
        static let detailItemSpacing:CGFloat = 10.0
    }
    
    // MARK: - View
    
    let book: Book
    
    var placeholderColors:[Color] {
        let colors:[Color] = [
            .themeAccentLight,
            .themeAccentLighter,
            .themeAccentLightest,
            .themeSecondary,
            .themeTertiary
        ]
        
        return colors
    }
    
    var body: some View {
        HStack {
            bookCover
            // details
            bookDetails
        }
        .frame(height: Constants.rowHeight)
    }
    
    // MARK: - Book Details
    
    var bookDetails: some View {
        
        VStack (alignment: .leading, spacing: Constants.detailItemSpacing) {
            
            // Title
            bookField("Title: ",
                      systemIconImage: "text.book.closed",
                      value: "Project Hail Mary")
            // Author
            bookField("Author: ",
                      systemIconImage: "person",
                      value: "Andy Weir")
            
            

            // ISBN
            // Publisher
            // Description
            // Published At
        }
    }
    
    @ViewBuilder
    private func bookField(_ labelText: String, systemIconImage: String, value: String) -> some View {
        HStack {
            Label(labelText, systemImage: systemIconImage)
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
    }
    
    // MARK: - Book Cover
    
    var bookCover: some View {
        
        Group {
            
            // if book cover
            
            // else
            placeholderCover
        }
    }
    
    var placeholderCover: some View {
        
        // background
        ZStack {
            
            let colorIndex = Int.random(in: 0..<placeholderColors.count)
            let coverColor = placeholderColors[colorIndex]
            
            RoundedRectangle(cornerRadius: Constants.placeholderCornerRadius)
                .fill(coverColor)
                .frame(width: Constants.bookCoverWidth)
            
            Text(getInitialsForName(book.author) ?? "Au")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .blendMode(.multiply)
                .opacity(0.5)
        }
    }
    
    private func getInitialsForName(_ name: String) -> String? {
        
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
             formatter.style = .abbreviated
             return formatter.string(from: components)
        }
        return nil
    }
    
}

struct BookRow_Previews: PreviewProvider {
    static var previews: some View {
        BookRow(book: Book.exampleAllDetails!)
    }
}
