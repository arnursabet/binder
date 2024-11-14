//
//  ProfileView.swift
//  Binder
//
//  Created by Iyu Lin on 2024/11/13.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack (spacing: 20){
            
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .foregroundColor(.gray)
                .offset(y: -55)

            Text("UserName")
                .font(.title)
                .foregroundColor(Color("wordColor"))
                .offset(y: -50)

            Text("My Goal")
                .font(.headline)
                .offset(y: -30)

            
            ProgressCircle(progress: 0.9)
                .padding(.top, 20)
                .offset(y: -30)
            
            Button(action: {}) {
                Text("Change Preference")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("backgrondColor1"))
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .padding(.horizontal, 50)
                
            }
            .offset(y: 20)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgrondColor1").opacity(0.4))
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileView()
}
