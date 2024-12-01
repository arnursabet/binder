//
//  ProfileView.swift
//  Binder
//
//  Created by Iyu Lin on 2024/11/13.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack (spacing: 10){
                
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .foregroundColor(.gray)
                    .offset(y: 100)
                
                Text("UserName")
                    .font(.title)
                    .foregroundColor(Color("wordColor"))
                    .offset(y: 120)
                
                Text("My Goal")
                    .font(.headline)
                    .offset(y: 170)
                
                
                ProgressCircle(progress: 0.9)
                    .padding(.top, 20)
                    .offset(y: 170)
                
                Button(action: {}) {
                    Text("Change Preference")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("backgrondColor1"))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .padding(.horizontal, 50)
                        .offset(y: 200)
                    
                }
                .offset(y: 20)
                
                Spacer()
                
                MenuBar()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("backgrondColor1").opacity(0.4))
            .ignoresSafeArea()
        }
    }
    
    struct ProfileView_Previews:
        PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
}
