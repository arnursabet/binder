//
//  BookRecomView.swift
//  Binder
//
//  Created by Amy Yu on 11/29/24.
//

import SwiftUI

enum LoadingState {
    case Success
    case NeverLoaded
    case Loading
    case Error(message: String)
    
    var isLoading: Bool {
        switch self {
        case .Success, .NeverLoaded, .Error:
            return false
        case .Loading:
            return true
        }
    }
    
    var isError: Bool {
        switch self {
        case .Success, .NeverLoaded, .Loading:
            return false
        case .Error:
            return true
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .Success, .NeverLoaded, .Loading:
            return nil
        case .Error(let message):
            return message
        }
    }
}
struct BookRecommendationView: View {
    let selectedCategory: String
    @State private var books: [BookModel] = []
    @State private var currentIndex = 0
    @State private var animateNextBook = false
    @State private var offset: CGFloat = 0
    @State private var navigateToLibrary = false
    @ObservedObject var libraryVM: LibraryViewModel
    @State private(set) var bookLoadingState = LoadingState.NeverLoaded
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                
                HStack {
                    Spacer()
                    LibraryButton(libraryVM: libraryVM)
                }
                .padding(.horizontal)
                .padding(.top, 5)
                .padding(.bottom)
                
                
                switch bookLoadingState {
                case .Success:
                    if currentIndex < books.count {
                        let currentBook = books[currentIndex]
                        
                        VStack {
                            
                            // Book Image
                            AsyncImage(url: URL(string: currentBook.imageLinks.thumbnail ?? "")) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 420)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Spacer()
                            
                            // Book Details
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "person.crop.circle.fill")
                                        .renderingMode(.template)
                                        .font(.title)
                                        .foregroundStyle(.yellow)
                                    Text((currentBook.authors?.count ?? 0 > 0 ? currentBook.authors?[0] : "") ?? "")
                                        .font(.subheadline)
                                        .bold()
                                    
                                    
                                    Spacer()
                                    
                                    Image(systemName: "tag.fill")
                                        .font(.title)
                                        .foregroundStyle(.yellow)
                                    Text(selectedCategory)
                                        .font(.subheadline)
                                }
                                .padding(.horizontal, 20)
                                
                                Text(currentBook.description ?? "")
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.primary)
                                    .lineLimit(5)
                                    .padding(.top, 4)
                            }
                        }
                        .offset(x: offset)
                        .animation(.spring(), value: offset)
                        // Reaction Buttons
                        HStack(spacing: 40) {
                            Button(action: {
                                // Dislike action
                                animateToNextBook()
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.red)
                            }
                            Spacer()
                            
                            Button(action: {
                                if books.count > currentIndex {
                                    libraryVM.addBookToLibrary(books[currentIndex])
                                    animateToNextBook()
                                }
                            }) {
                                Image(systemName: "heart.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        
                        
                        
                    } else {
                        Spacer()
                        Text("No more recommendations!")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                        Spacer()
                        
                    }
                case .NeverLoaded:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .Loading:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .Error(let message):
                    Spacer()
                    Text(message)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                
                
                
            }.onAppear {
                Task {
                    bookLoadingState = .Loading
                    do {
                        let api = GoogleBooksAPI()
                        self.books = try await api.fetchBooks(searchTerm: "subject:\(selectedCategory)")
                        
                        bookLoadingState = .Success
                        currentIndex = 0
                    } catch {
                        bookLoadingState = .Error(message: error.localizedDescription)
                    }
                }
            }
            .padding(.horizontal, 40)
            .background(Color("backgrondColor1").opacity(0.4))
            
        }
    }
    
    private func animateToNextBook() {
        // Animate the view off-screen
        offset = UIScreen.main.bounds.width
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            // Move to the next book
            currentIndex += 1
            // Reset offset for the next book
            offset = -UIScreen.main.bounds.width
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                offset = 0
            }
        }
    }
}

// Preview
struct BookRecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        BookRecommendationView(selectedCategory: "law", // test
                               libraryVM: LibraryViewModel())
    }
}
