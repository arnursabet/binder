//
//  LibraryButton.swift
//  Binder
//
//  Created by Iyu Lin on 2024/12/12.
//

import SwiftUI

struct LibraryButton: View {
    @ObservedObject var libraryVM: LibraryViewModel

    var body: some View {
        NavigationLink(destination: LibraryView(libraryVM: libraryVM)) {
            VStack {
                Image(systemName: "books.vertical")
                    .font(.system(size: 25))
//                Text("My Library")
//                    .font(.footnote)
            }
            .foregroundColor(.black)
        }
    }
}
