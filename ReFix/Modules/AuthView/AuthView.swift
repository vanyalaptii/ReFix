//
//  LoginView.swift
//  ReFix
//
//  Created by Ivan Laptii on 30.12.2023.
//

import SwiftUI

struct AuthView: View {
    @Binding var showAuthView: Bool
    @EnvironmentObject var viewModel: AuthViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.authState == .signIn {
                    SignInView(showAuthView: $showAuthView)
                        .environmentObject(viewModel)
                } else if viewModel.authState == .signUp {
                    SignUpView(showAuthView: $showAuthView)
                        .environmentObject(viewModel)
                }
            }
            .ignoresSafeArea()
        }
        .onTapGesture {
            isFocused = false
        }
    }
}

#Preview {
    AuthView(showAuthView: .constant(false))
}
