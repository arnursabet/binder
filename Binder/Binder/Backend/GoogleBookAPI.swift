//
//  GoogleBookAPI.swift
//  Binder
//
//  Created by Chris Lee on 11/21/24.
//

import Foundation

struct Secrets {
    static var googleBooksAPIKey: String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: path),
              let apiKey = dictionary["GoogleBooksAPIKey"] as? String else {
            fatalError("Secrets.plist is missing or API key is not set.")
        }
        return apiKey
    }
}

//Defining a model for book data
struct BookModel: Codable {
    let title: String
    let authors: [String]?
    let description: String?
}

struct GoogleBooksResponse: Codable {
    
    struct VolumeInfo: Codable {
        let title: String
        let authors: [String]?
        let description: String?
    }
    
    struct Item: Codable {
        let volumeInfo: VolumeInfo
    }
    
    let items: [Item]
}

class GoogleBooksAPI {
    let apiKey = Secrets.googleBooksAPIKey // Replace with your API Key
    
    func fetchBooks(searchTerm: String) async throws -> [BookModel] {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(searchTerm)&key=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decodedResponse = try JSONDecoder().decode(GoogleBooksResponse.self, from: data)
        
        // Map to a simpler Book model
        return decodedResponse.items.map {
            BookModel(title: $0.volumeInfo.title,
                      authors: $0.volumeInfo.authors,
                      description: $0.volumeInfo.description)
        }
    }
    
    func fetchRandomBooks(searchTerm: String = "fiction") async throws -> BookModel? {
        let books = try await fetchBooks(searchTerm: searchTerm)
        return books.randomElement()
        
    }
}
