//
//  MyBooksViewModel.swift
//  iOSNetworking
//
//  Created by Brent on 9/8/2022.
//

import Foundation

class MyBooksViewModel: APIViewModel, ObservableObject {
    
    // need a variable for the stored books.
    @Published private(set) var books: [Book]?
    // need a call to save a book.
    
    func deleteBook(uuid: String) async throws {
        
        self.books?.removeAll(where: { $0.uuid == uuid }) // removes the element from the array so that it doesn't reappear.
        
        let _ = try await self.performRequest(DeleteBookRequest(uuid: uuid))
        
        try await fetchBooks()
        
    }
    
    func saveBook( bookDetails: BaseBookRequest.BookDetails ) async throws {
        
        let _ = try await self.performRequest(SaveBookRequest(bookDetails: bookDetails))
        
        // fetch books to update the list again.
        try await fetchBooks()
    }
    
    func updateBook(uuid: String,  bookDetails: BaseBookRequest.BookDetails ) async throws {
        
        let _ = try await self.performRequest(UpdateBookRequest(uuid: uuid, bookDetails: bookDetails))
        
        // fetch books to update the list again.
        try await fetchBooks()
    }
    
    @MainActor
    func fetchBooks() async throws {

        if let response = try await self.performRequest(GetAllSavedBooksRequest()) {
            
            if let bookPage = try self.parseJSONData(response, type: BookPage.self) {
                self.books = bookPage.data
            }
        }
    }
    
    // Helper function
    func makeBookDetails(
        title: String,
        author: String,
        isbn: String? = nil,
        publisher: String? = nil,
        publishedAt: String? = nil,
        description: String? = nil
    ) -> BaseBookRequest.BookDetails {
        
        BaseBookRequest.BookDetails(
            title: title, author: author, isbn: isbn, publisher: publisher, publishedAt: publishedAt, description: description)
        
    }
}
