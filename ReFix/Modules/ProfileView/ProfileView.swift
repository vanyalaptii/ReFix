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
            VStack(alignment: .center) {
                List {
                    //TODO: Fix backgroud color in both color schemes
                    Section("Налаштування") {
                        VStack(alignment: .leading, spacing: 0) {
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
                            .padding(15)
                            
                            Divider()
                            
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
                            .padding(15)
                            .foregroundStyle(.red)
                            .fontWeight(.semibold)
                            .buttonStyle(.borderless)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .circular)
                                .stroke(Color(uiColor: .tertiaryLabel), lineWidth: 1)
                        )
                    }
                    
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
                        .padding(15)
                        .foregroundStyle(.red)
                        .fontWeight(.bold)
                        .buttonStyle(.borderless)
                        
                        Spacer()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .circular)
                            .stroke(Color(uiColor: .tertiaryLabel), lineWidth: 1)
                    )
                }
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitle("Налаштування")
        }
    }
}

#Preview {
    ProfileView(userIsLoggedIn: .constant(true))
}
