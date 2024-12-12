//
//  HomeView.swift
//  Binder
//
//  Created by Iyu Lin on 2024/11/22.
//
import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

class HomeViewModel: ObservableObject {
    @Published var navigateToCategory = false

    func signInWithGoogle() {
        guard let presentingViewController = getRootViewController() else { return }

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }

            guard let signInResult = signInResult else {
                print("No sign-in result")
                return
            }

            guard let idToken = signInResult.user.idToken?.tokenString else {
                print("Error retrieving id token")
                return
            }

            let accessToken = signInResult.user.accessToken.tokenString

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase sign-in error: \(error.localizedDescription)")
                } else {
                    print("User signed in: \(authResult?.user.displayName ?? "")")
                    DispatchQueue.main.async {
                        self.navigateToCategory = true
                    }
                }
            }
        }
    }

    func getRootViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else {
            fatalError("No root view controller found")
        }
        return rootVC
    }

    func checkUser() {
        if Auth.auth().currentUser != nil {
            navigateToCategory = true
        }
    }
}

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                logoView
                
                textStack
                
                Spacer()
                
                googleSignInButton
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("backgrondColor1").opacity(0.4))
            .ignoresSafeArea()
            .navigationDestination(isPresented: $viewModel.navigateToCategory) {
                CategorySelectionView()
            }
        }
        .onAppear {
            viewModel.checkUser()
        }
    }
    
    private var logoView: some View {
        ZStack {
            Image("binderLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 275, height: 275)
        }
        .padding(25)
    }
    
    private var textStack: some View {
        VStack(spacing: 15) {
            ForEach(["EXPLORE", "READ", "SHARE"], id: \.self, content: { text in
                Text(text)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color("wordColor"))
            })
        }
    }
    
    private var googleSignInButton: some View {
        Button(action: viewModel.signInWithGoogle) {
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
    }
}

#Preview {
    HomeView()
}
