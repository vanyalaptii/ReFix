//
//  ContentView.swift
//  ReFix
//
//  Created by Ivan Laptii on 17.12.2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            TabView {
                RelpairsListView()
                    .tabItem {
                        Label("Ремонти", systemImage: "list.dash.header.rectangle")
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                
                ClientsListView()
                    .tabItem {
                        Label("Клієнти", systemImage: "person.2")
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                
                ConteragentListView()
                    .tabItem {
                        Label("Контрагенти", systemImage: "wrench.and.screwdriver.fill")
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                
                ProfileView(showAuthView: $authViewModel.showAuthView)
                    .tabItem {
                        Label("Профіль", systemImage: "person.crop.rectangle")
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(.visible, for: .navigationBar)
            }
        }
        .onAppear {
            let authUser = try?  AuthenticationManager.shared.getAuthenticatedUser()
            authViewModel.showAuthView = authUser == nil ? true : false
        }
        .fullScreenCover(isPresented: $authViewModel.showAuthView) {
            NavigationStack {
                AuthView(showAuthView: $authViewModel.showAuthView)
                    .environmentObject(authViewModel)
            }
        }
    }
}

#Preview {
    MainView()
}
