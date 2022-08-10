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
    
    @EnvironmentObject private var model:MyBooksViewModel
    
    var books: [Book]? { model.books }
    
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
        .task {
            print("referesh books")
            await refreshBooks()
        }
        .environmentObject(model)

    }
    
    private func refreshBooks() async {
        
        do {
            try await model.fetchBooks()
        } catch {
            print(error)
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
            .onDelete(perform: { indexSet in // not essential for demo.
                
                Task {
                    
                    if let first = indexSet.first {
                        let book = books[first]
                        do {
                            try await model.deleteBook(uuid:book.uuid)
                        } catch {
                            print(error)
                        }
                    } else {
                        print("no book to delete.")
                    }
                }
                
            })
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
        
        MyBooksView()
            .nestInNavigationView(selectedTab: Tabs.myBooks.rawValue)
            .environmentObject(MyBooksViewModel())
    }
}
