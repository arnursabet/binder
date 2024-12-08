//
//  LibraryView.swift
//  Binder
//
//  Created by Amy Yu on 11/21/24.

// still need to add a random book generator


import SwiftUI

struct LibraryView: View {
    @ObservedObject var libraryVM: LibraryViewModel
    
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
                Text("\(libraryVM.libraryBooks.count) books")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding(40)
            
            // Book Grid
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 45), // First column
                        GridItem(.flexible(), spacing: 45)  // Second column
                    ],
                    spacing: 40 // Space between rows
                ) {
                    if self.libraryVM.libraryBooks.count > 0 {
                        ForEach(0..<self.libraryVM.libraryBooks.count, id: \.self) { index in
                            VStack {
                                AsyncImage(url: URL(string: self.libraryVM.libraryBooks[index].imageLinks.thumbnail ?? "")) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 220)
                                        .clipped()
                                        .background(Color.gray.opacity(0.1))
                                } placeholder: {
                                    ProgressView()
                                        .frame(height: 220)
                                } 

                                Text(self.libraryVM.libraryBooks[index].title) // Assuming books have a title
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                libraryVM.fetchLibraryBooks()
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
        .background(Color("backgrondColor1").opacity(0.3))
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
    LibraryView(libraryVM: LibraryViewModel())
}
