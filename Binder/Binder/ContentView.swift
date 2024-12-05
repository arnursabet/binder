//
//  ContentView.swift
//  Binder
//
//  Created by Chris Lee on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var randomBook: BookModel?
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            if let book = randomBook {
                Text(book.title)
                    .font(.headline)
                    .padding()
                
            }
            Button("Fetch Random Book") {
                Task {
                    do {
                        let api = GoogleBooksAPI()
                        randomBook = try await api.fetchRandomBooks()
                    } catch {
                        errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
