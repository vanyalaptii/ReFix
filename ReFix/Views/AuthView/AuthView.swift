//
//  LoginView.swift
//  ReFix
//
//  Created by Ivan Laptii on 30.12.2023.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.authState == .signIn {
                    SignInView()
                        .environmentObject(viewModel)
                } else if viewModel.authState == .signUp {
                    SignUpView()
                        .environmentObject(viewModel)
                }
            }
            .background(Color(.secondarySystemBackground), ignoresSafeAreaEdges: .all)
            .ignoresSafeArea()
        }
        .onTapGesture {
            isFocused = false
        }
    }
}

#Preview {
    AuthView()
}