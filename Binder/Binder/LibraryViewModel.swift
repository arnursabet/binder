//
//  LibraryViewModel.swift
//  Binder
//
//  Created by Amy Yu on 12/07/24.
//

import SwiftUI

final class LibraryViewModel: ObservableObject {

    @Published var libraryBooks: [BookModel] = []
    @Published var tempLibraryBooks: [BookModel] = []

    func addBookToLibrary(_ book: BookModel) {
        if !self.tempLibraryBooks.contains(where: {$0.title == book.title}) {
            self.tempLibraryBooks.append(book)
            self.tempLibraryBooks.reverse()
        }
    }
    
    func fetchLibraryBooks() {
        self.libraryBooks = self.tempLibraryBooks
    }
}
