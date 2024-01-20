//
//  LoginView.swift
//  ReFix
//
//  Created by Ivan Laptii on 30.12.2023.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
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
            .ignoresSafeArea()
        }
    }
}

#Preview {
    AuthView()
}
