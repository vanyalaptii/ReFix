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
            TabView(selection: $authViewModel.tabSelection) {
                RelpairsListView()
                    .tabItem {
                        Label("Ремонти", systemImage: "list.dash.header.rectangle")
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                    .tag("Relpairs")
                
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
                
                ProfileView(showAuthView: $authViewModel.showAuthView)
                    .tabItem {
                        Label("Профіль", systemImage: "person.crop.rectangle")
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .tag("ProfileView")
            }
        }
        .fullScreenCover(isPresented: $authViewModel.showAuthView) {
            AuthView()
                .environmentObject(authViewModel)
        }
    }
}

#Preview {
    MainView()
}
