//
//  BookRecomView.swift
//  Binder
//
//  Created by Amy Yu on 11/29/24.
//

import SwiftUI

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let category: String
    let description: String
    let imageURL: String
}

struct BookRecommendationView: View {
    @State private var books: [Book] = [
        Book(
            title: "Dune",
            author: "Frank Herbert",
            category: "Fiction",
            description: """
            Set on the desert planet Arrakis, Dune is the story of Paul Atreides—who would become known as Muad’Dib—and of a great family’s ambition to bring to fruition humankind’s most ancient and unattainable dream.
            """,
            imageURL: "https://cdna.artstation.com/p/assets/images/images/042/950/438/large/giova-favazzi-dune-web.jpg?1635881704"
        ),
        Book(
            title: "1984",
            author: "George Orwell",
            category: "Fiction",
            description: """
            A dystopian social science fiction novel and cautionary tale about the dangers of totalitarianism.
            """,
            imageURL: "https://example.com/1984.jpg"
        )
    ]
    
    @State private var currentIndex = 0
    @State private var animateNextBook = false
    @State private var offset: CGFloat = 0

    var body: some View {
        VStack(spacing: 20) {
            if currentIndex < books.count {
                let currentBook = books[currentIndex]
                
                VStack {
                    Text("Book Recommendation")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.top)
                    Spacer()
                    
                    // Book Image
                    AsyncImage(url: URL(string: currentBook.imageURL)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Book Details
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .renderingMode(.template)
                                .font(.title)
                                .foregroundStyle(.yellow)
                            Text(currentBook.author)
                                .underline()
                                .font(.subheadline)
//                                .foregroundColor(.secondary)
                                .bold()
                            
                            
                            Spacer()
                            
                            Image(systemName: "tag.fill")
                                .font(.title)
                                .foregroundStyle(.yellow)
                            Text(currentBook.category)
                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                                .italic()
                        }
                        .padding(.horizontal, 20)
                        
                        Text(currentBook.description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                            .lineLimit(5)
                            .padding(.top, 4)
                    }
                }
                .offset(x: offset)
                .animation(.spring(), value: offset)
            } else {
                Text("No more recommendations!")
                    .font(.headline)
                    .padding()
            }
            
            // Reaction Buttons
            HStack(spacing: 40) {
                Button(action: {
                    // Dislike action
                    print("Dislike button tapped")
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.red)
                }
                Spacer()
                
                Button(action: {
                    animateToNextBook()
                }) {
                    Image(systemName: "smiley.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.green)
                }
            }
            .padding()
            
            // Bottom Navigation
//            HStack {
//                Button(action: {
//                    // Navigate to My Library
//                }) {
//                    VStack {
//                        Image(systemName: "books.vertical")
//                            .font(.title2)
//                        Text("My Library")
//                            .font(.footnote)
//                    }
//                }
//                Spacer()
//                
//                Button(action: {
//                    // Navigate to Profile
//                }) {
//                    VStack {
//                        Image(systemName: "person.circle")
//                            .font(.title2)
//                        Text("Profile")
//                            .font(.footnote)
//                    }
//                }
//                Spacer()
//                
//                Button(action: {
//                    // Logout action
//                }) {
//                    VStack {
//                        Image(systemName: "arrowshape.turn.up.left")
//                            .font(.title2)
//                        Text("Log out")
//                            .font(.footnote)
//                    }
//                }
//            }
//            .padding()
//            .background(Color(UIColor.systemGray6))
//            .cornerRadius(10)
//            .padding(.horizontal)
        }
        .padding(.horizontal, 40)
        .background(Color("backgrondColor1"))
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
        BookRecommendationView()
    }
}
