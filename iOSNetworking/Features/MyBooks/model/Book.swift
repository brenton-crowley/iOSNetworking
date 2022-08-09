//
//  Book.swift
//  iOSNetworking
//
//  Created by Brent on 3/8/2022.
//

import Foundation

struct BookPage: Decodable {
    
    var data: [Book]
    
}

struct Book: Identifiable, Decodable {
    
    var title, author, uuid: String
    var isbn, publisher, description, publishedAt: String?
    var id: String { uuid }
    
}

extension Book {
    
    static var exampleMinDetails: Book? {
        return Book(
            title: "LOTR: The Fellowship of the Ring",
            author: "J.R.R. Tolkien",
            uuid: UUID().uuidString)
    }
    
    static var exampleAllDetails: Book? {
        
        if var book = Book.exampleMinDetails {
            book.title = "The Martian"
            book.author = "Andy Weir"
            book.uuid = UUID().uuidString
            book.isbn = "123456789"
            book.publishedAt = "29 July 1954"
            book.publisher = "George Allen & Unwin"
            book.description = "In the Second Age of Middle-earth, the lords of Elves, Dwarves, and Men are given Rings of Power. Unbeknownst to them, the Dark Lord Sauron forges the One Ring in Mount Doom, instilling into it a great part of his power, in order to dominate the other Rings so he might conquer Middle-earth."
            return book
        }
        
        return nil
    }
    
    static var books:[Book]? {
        if let book = exampleAllDetails,
           let book2 = exampleMinDetails {
            return [
                book,
                book2
            ]
        }
        return nil
    }
    
}
