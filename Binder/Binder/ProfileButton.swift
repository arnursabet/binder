//
//  ProfileButton.swift
//  Binder
//
//  Created by Iyu Lin on 2024/12/12.
//

import SwiftUI

struct ProfileButton: View {
    var body: some View {
        NavigationLink(destination: ProfileView()) {
            VStack {
                Image(systemName: "person.fill")
                    .font(.system(size: 25))
            }
            .foregroundColor(.black)
        }
    }
}

struct ProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileButton()
        }
    }
}
