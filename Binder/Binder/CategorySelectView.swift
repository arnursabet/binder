//
//  CategorySelectView.swift
//  Binder
//
//  Created by Iyu Lin on 2024/11/22.
//

import SwiftUI

struct CategorySelectionView: View {
    @State private var navigateToProfile = false
    
    @State private var selectedCategory = "Select"
    @State private var monthlyGoal = ""
    

    let categories = ["Fiction", "Non-Fiction", "Fantasy", "Commercial", "Biography"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                Spacer()
                
                Text("WELCOME")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("wordColor"))
                
                Spacer()
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Please select categories")
                        .font(.subheadline)
                        .foregroundColor(Color("wordColor"))
                        .padding(.leading, 30)
                    
                    HStack {
                        Picker("Select", selection: $selectedCategory) {
                            ForEach(categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Spacer()
                        
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color("SelectorColor"))
                    .cornerRadius(15)
                    .padding(.horizontal, 40)
                    
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Please set your month goal")
                        .font(.subheadline)
                        .foregroundColor(Color("wordColor"))
                        .padding(.leading, 30)
                    
                    TextField("...books per month", text: $monthlyGoal)
                        .padding()
                        .background(Color("SelectorColor"))
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                Button(action: {
                    print("Category: \(selectedCategory), Goal: \(monthlyGoal)")
                    navigateToProfile = true
                    
                }) {
                    Text("Confirm")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("buttonColor"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("backgrondColor1").opacity(0.4))
            .ignoresSafeArea()
            .navigationDestination(isPresented: $navigateToProfile) {
                ProfileView()
            }
        }
    }
}

struct CategoriesSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySelectionView()
    }
}

