//
//  ProfileView.swift
//  ReFix
//
//  Created by Ivan Laptii on 30.12.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var userIsLoggedIn: Bool
    
    var body: some View {
        NavigationStack {
            List {
                //TODO: Fix backgroud color in both color schemes
                settingsSection
                logOutButton
            }
            .scrollDisabled(true)
            .navigationBarTitle(viewModel.user?.companyName ?? "Профіль")
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

extension ProfileView {
    private var settingsSection: some View {
        Section("Налаштування") {
                Button("Скинути пароль"){
                    Task {
                        do {
                            try await viewModel.updatePassword()
                        } catch {
                            print(error)
                        }
                    }
                }
                .buttonStyle(.borderless)
                
                //MARK: reSignIn required
                Button("Видалити акаунт"){
                    Task {
                        do {
                            try await viewModel.deleteAccount()
                            withAnimation {
                                userIsLoggedIn = false
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
                .foregroundStyle(.red)
                .fontWeight(.semibold)
                .buttonStyle(.borderless)
        }
    }
    
    private var logOutButton: some View {
        HStack {
            Spacer()
            
            Button("Вийти"){
                Task {
                    do {
                        try viewModel.signOut()
                        userIsLoggedIn = false
                    } catch {
                        print(error)
                    }
                }
            }
            .foregroundStyle(.red)
            .fontWeight(.bold)
            .buttonStyle(.borderless)
            
            Spacer()
        }
    }
}

#Preview {
    ProfileView(userIsLoggedIn: .constant(true))
}
