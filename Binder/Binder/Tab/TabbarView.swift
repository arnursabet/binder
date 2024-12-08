//
//  TabbarView.swift
//  Binder
//
//  Created by Amy Yu on 12/08/24.
//

import SwiftUI

enum TabItem: String {
    case home
    case myLibrary
    case myProfile
    
    var title: String {
        switch self {
        case .home:
            "Home"
        case .myLibrary:
            "My Library"
        case .myProfile:
            "Profile"
        }
    }
}
struct TabbarView: View {
    
    // MARK: - Properties -
    @State var selectedTab: TabItem = TabItem.home
    @StateObject private var libraryVM = LibraryViewModel()
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("backgrondColor2").opacity(0.45))
    }
    // MARK: - body -
    var body: some View {
        TabView(selection: $selectedTab) {
            
            BookRecommendationView(libraryVM: libraryVM)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text(TabItem.home.title)
                }
                .tag(TabItem.home)
            LibraryView(libraryVM: libraryVM)
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text(TabItem.myLibrary.title)
                }
                .tag(TabItem.myLibrary)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text(TabItem.myProfile.title)
                }
                .tag(TabItem.myProfile)
        }
        .accentColor(.black) /* Tabbar Tint color */
    }
}
