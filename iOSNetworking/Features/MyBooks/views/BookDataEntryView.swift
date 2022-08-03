//
//  BookDataEntryView.swift
//  iOSNetworking
//
//  Created by Brent on 3/8/2022.
//

import SwiftUI

struct BookDataEntryView: View {
    
    private struct Constants {
        
        // View title
        static let addBookTitle = "Add Book"
        static let updateBookTitle = "Update Book"
        
        // Dismiss button
        static let dismissSystemImage = "x.circle.fill"
        static let dismissButtonHeight:CGFloat = 25.0
        
        // TextEditor
        static let multilineTextfieldHeight:CGFloat = 120
        static let doubleLineTextfieldHeight:CGFloat = 60.0
        static let singleLineTextfieldHeight:CGFloat = 30.0
        
        // Decided to not create constants for each of the fields as it would just lead to unnecessary bloat. Scroll down to edit those values.
        
    }
    
    var book: Book?
    var viewTitle:String {
        return book == nil ? Constants.addBookTitle : Constants.updateBookTitle
    }
    
    @State private var titleText: String = ""
    @State private var authorText: String = ""
    @State private var publisherText: String = ""
    @State private var isbnText: String = ""
    @State private var publishedAtText: String = ""
    @State private var descriptionText: String = ""
    
    @Binding var isPresented: Bool
    
    var body: some View {
        
        NavigationView {
            List {
                title
                author
                isbn
                publisher
                publishedAtDate
                description
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewTitle)
            .listStyle(.insetGrouped)
            .onAppear {
                if let book = book {
                    titleText = book.title
                    authorText = book.author
                    publisherText = book.publisher ?? ""
                    isbnText = book.isbn ?? ""
                    publishedAtText = book.publishedAt ?? ""
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    dismissButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    sendRequestButton
                }
            }
        }
    }
    
    // MARK: - Toolbar Buttons
    
    var dismissButton: some View {
        
        Button("Cancel") {
            isPresented = false
        }
    }
    
    var sendRequestButton: some View {
        
        Group {
            if book == nil {
                Button("Add") {
                    isPresented = false
                    // TODO: Send POST request
                    // get list of books
                }
            } else {
                Button("Update") {
                    isPresented = false
                    // TODO: Send PUT request
                    // get list of books
                }
            }
            
        }
    }
    
    // MARK: - Data Entry Fields
    
    var title: some View {
        
        dataEntryField(
            labelText: "Title: ",
            labelSystemIcon: "text.book.closed",
            boundText: $titleText,
            prompt: "What's the book's title?")
        
    }
    
    var author: some View {
        
        dataEntryField(
            labelText: "Author: ",
            labelSystemIcon: "person",
            boundText: $authorText,
            prompt: "What's the author's name?",
            height: Constants.singleLineTextfieldHeight)
        
    }
    
    var isbn: some View {
        
        dataEntryField(
            labelText: "ISBN: ",
            labelSystemIcon: "number",
            boundText: $isbnText,
            prompt: "What's the book's isbn?",
            height: Constants.singleLineTextfieldHeight)
        
    }
    
    var publisher: some View {
        
        dataEntryField(
            labelText: "Publisher: ",
            labelSystemIcon: "building.columns",
            boundText: $publisherText,
            prompt: "Who's the book's publisher?",
            height: Constants.singleLineTextfieldHeight)
        
    }
    
    var publishedAtDate: some View {
        
        dataEntryField(
            labelText: "Date Published: ",
            labelSystemIcon: "calendar",
            boundText: $publishedAtText,
            prompt: "When was the book published?",
            height: Constants.singleLineTextfieldHeight)
        
    }
    
    var description: some View {
        
        dataEntryField(
            labelText: "Description: ",
            labelSystemIcon: "text.alignleft",
            boundText: $descriptionText,
            prompt: "What's the book about?",
            height: Constants.multilineTextfieldHeight)
        
    }
    
    @ViewBuilder
    private func dataEntryField(
        labelText: String,
        labelSystemIcon: String,
        boundText: Binding<String>,
        prompt:String? = nil,
        height: CGFloat = Constants.doubleLineTextfieldHeight) -> some View {
            
            Section {
                TextEditor(text: boundText)
                    .font(.callout)
                    .frame(height: height)
            } header: {
                Label(prompt ?? labelText, systemImage: labelSystemIcon)
                //                    .foregroundColor(.secondary)
                
            }
        }
}

struct BookDataEntryView_Previews: PreviewProvider {
    static var previews: some View {
        BookDataEntryView(
            book: Book.exampleAllDetails!,
            isPresented: Binding.constant(true))
    }
}
