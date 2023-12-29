//
//  ContentView.swift
//  ReFix
//
//  Created by Ivan Laptii on 17.12.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            RelpairsListView()
                .tabItem {
                    Label("Ремонти", systemImage: "list.dash.header.rectangle")
                }
                .toolbarBackground(.visible, for: .tabBar)
            
            ClientsListView()
                .tabItem {
                    Label("Клієнти", systemImage: "person.crop.circle")
                }
                .toolbarBackground(.visible, for: .tabBar)
            
            ConteragentListView()
                .tabItem {
                    Label("Контрагенти", systemImage: "wrench.and.screwdriver.fill")
                }
                .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    MainView()
}
