//
//  MyBooksView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct MyBooksView: View {
    
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
        VStack (alignment: .center) {
            Label("Oops!", systemImage: "books.vertical.fill")
                .font(.largeTitle)
                .foregroundColor(.themeAccentLighter)
            Text("You don't have any **books** in your library. Click the **plus button +** in the top right corner add a book.")
                .padding(.horizontal, 20.0)
                .padding(.top, 5.0)
                .multilineTextAlignment(.center)
        }
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
                        viewTitle: "Update Book",
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
            Image(systemName: "plus")
        }
        .sheet(isPresented: $isAddBookPresented) {
            BookDataEntryView(viewTitle: "Add Book", isPresented: $isAddBookPresented)
        }
    }
}

struct MyBooksView_Previews: PreviewProvider {
    static var previews: some View {
        
        let books: [Book]? = Book.books
        
        MyBooksView(books: books)
            .nestInNavigationView(selectedTab: Tabs.myBooks.rawValue)
    }
}
