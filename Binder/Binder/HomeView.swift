//
//  HomeView.swift
//  Binder
//
//  Created by Iyu Lin on 2024/11/22.
//
import SwiftUI

struct HomeView: View {
    @State private var navigateToCategory = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color("SelectorColor"))
                        .frame(width: 200, height: 200)
                    
                    Image(systemName: "books.vertical")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                .padding(45)
                
                VStack(spacing: 15) {
                    Text("EXPLORE")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color("wordColor"))
                    
                    Text("READ")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color("wordColor"))
                    
                    
                    Text("SHARE")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color("wordColor"))
                    
                }
                
                Spacer()
                
                Button(action: {
                    print("Google Login")
                    navigateToCategory = true
                }) {
                    HStack {
                        Image("search")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.leading, 10)
                        
                        Text("LOG IN WITH GOOGLE")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.horizontal, 10)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: 300)
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 5)
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("backgrondColor1").opacity(0.4))
            .ignoresSafeArea()
            .navigationDestination(isPresented: $navigateToCategory) {
                CategorySelectionView()
            }
        }
    }
}

            struct HomepageView_Previews: PreviewProvider {
                static var previews: some View {
                    HomeView()
                }
            }
