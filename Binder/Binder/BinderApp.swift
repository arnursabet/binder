//
//  BinderApp.swift
//  Binder
//
//  Created by Chris Lee on 11/11/24.
//

import SwiftUI

@main
struct BinderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            HomeView()
//            ContentView()
//            BookRecommendationView(libraryVM: libraryVM)
            // TabbarView()
        }
    }
}
