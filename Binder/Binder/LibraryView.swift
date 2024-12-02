//
//  LibraryView.swift
//  Binder
//
//  Created by Amy Yu on 11/21/24.

// still need to add a random book generator


import SwiftUI

struct LibraryView: View {
    // Example book data
    let books = [
        ("Dune", "dune_cover"), // Replace with actual asset names
        ("Atomic Habits", "atomic_habits_cover"),
        ("Yellowface", "yellowface_cover"),
        ("Harry Potter", "harry_potter_cover")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Library Info
            HStack {
                Spacer()
                Spacer()
                Spacer()
                Text("My Library")
                    .font(.title)
                    .foregroundColor(.gray)
//                    .padding(.top, 20)
                Spacer()
                Text("\(books.count) books")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding(40)
            
            // Book Grid
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(books, id: \.0) { book in
                        VStack {
                            Image(book.1) // Use asset names for book covers
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:150, height: 200)
//                                .cornerRadius(10)
                            
//                            Text(book.0)
//                                .font(.caption)
//                                .multilineTextAlignment(.center)
//                                .foregroundColor(.black)
                        }
                    }
                }
                .padding()
            }
            
            // Bottom Navigation
//            HStack {
//                NavigationButton(icon: "book", label: "My Library")
//                NavigationButton(icon: "person", label: "Profile")
//                NavigationButton(icon: "rectangle.portrait.and.arrow.right", label: "Log out")
//            }
//            .frame(height: 90)
//            .background(Color("backgroundColor1"))
        }
//        .background(Color("backgroundColor1").opacity(0.3))
        .background(Color("backgrondColor1"))
        .ignoresSafeArea(edges: .bottom)
    }
}

// Helper for Bottom Navigation Button
struct NavigationButton: View {
    let icon: String
    let label: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(.black)
            Text(label)
                .font(.caption)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    LibraryView()
}
