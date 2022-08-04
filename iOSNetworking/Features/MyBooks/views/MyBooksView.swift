//
//  MyBooksView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct MyBooksView: View {
    
    private struct Constants {
        
        // Empty libary
        static let libraryEmptyMessage = "You don't have any books in your library. Click the plus button + in the top right corner to add a book."
        static let libraryEmptySystemIcon = "books.vertical.fill"
        
        
        // System Icon
        static let addBookSystemIcon = "plus"
    }
    
    @State private var isAddBookPresented = false
    @State private var isUpdateBookPresented = false
    
    var books: [Book]?
    
    var body: some View {
        VStack {
            if let books = books {
                bookRowsForBooks(books)
            } else {
                noBooksFeedback
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                UserProfileButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                addBookButton
            }
        }
    }
    
    var noBooksFeedback: some View {
        OopsView(
            systemIconImage: Constants.libraryEmptySystemIcon,
            messageText: Constants.libraryEmptyMessage)
    }
    
    @ViewBuilder
    private func bookRowsForBooks(_ books: [Book]) -> some View {
        List {
            ForEach(books) { book in
                
                Button {
                    isUpdateBookPresented = true
                } label: {
                    BookRow(book: book)
                }.sheet(isPresented: $isUpdateBookPresented) {
                    BookDataEntryView(
                        book: book,
                        isPresented: $isUpdateBookPresented)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        
    }
    
    var addBookButton: some View {
        Button {
            isAddBookPresented = true
        } label: {
            Image(systemName: Constants.addBookSystemIcon)
        }
        .sheet(isPresented: $isAddBookPresented) {
            BookDataEntryView(isPresented: $isAddBookPresented)
        }
    }
}

struct MyBooksView_Previews: PreviewProvider {
    static var previews: some View {
        
        let books: [Book]? = nil //Book.books
        
        MyBooksView(books: books)
            .nestInNavigationView(selectedTab: Tabs.myBooks.rawValue)
    }
}
