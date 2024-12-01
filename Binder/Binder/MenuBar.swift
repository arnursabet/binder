//
//  MenuBar.swift
//  Binder
//
//  Created by Iyu Lin on 2024/11/21.
//

import SwiftUI

struct MenuBar: View {
    var body: some View {
        HStack {
            // MyLibrary button

            NavigationLink(destination: LibraryView()) {

                VStack{
                    Image(systemName: "book.fill").font(.system(size: 25))
                    Text("My Library")
                        .font(.footnote)
                }
                .foregroundColor(.black)
            }
                
            
            Spacer()
            // Profile button
            NavigationLink(destination: ProfileView()) {
                VStack{
                    Image(systemName: "person.fill").font(.system(size: 25))
                    Text("My Profile")
                        .font(.footnote)
                }
                .foregroundColor(.black)
                
            }
            Spacer()
            // Logout button

            NavigationLink(destination: HomeView()){
                
                VStack{
                    Image(systemName: "rectangle.portrait.and.arrow.forward").font(.system(size: 25))
                    Text("Logout")
                        .font(.footnote)
                }
                .foregroundColor(.black)
            }
            }
            
        
        .padding()
        .background(Color("backgrondColor2").opacity(0.7))
    }
}
    
struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MenuBar()
        }
    }
}
    
