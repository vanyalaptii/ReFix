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
        switch authViewModel.isUserLoggedIn {
        case true:
            mainView
        default:
            authView
        }
    }
}

extension MainView {
    var authView: some View {
        AuthView()
            .environmentObject(authViewModel)
    }
    
    var mainView: some View {
        TabView(selection: $authViewModel.tabSelection) {
            RepairsListView()
                .tabItem {
                    Label("Ремонти", systemImage: "list.dash.header.rectangle")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .tag("Repairs")
            
            ClientsListView()
                .tabItem {
                    Label("Клієнти", systemImage: "person.2")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .tag("Clients")
            
            ConteragentListView()
                .tabItem {
                    Label("Контрагенти", systemImage: "wrench.and.screwdriver.fill")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .tag("Conteragent")
            
            ProfileView(userIsLoggedIn: $authViewModel.isUserLoggedIn)
                .tabItem {
                    Label("Профіль", systemImage: "person.crop.rectangle")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .tag("ProfileView")
        }
    }
}

#Preview {
    MainView()
}
