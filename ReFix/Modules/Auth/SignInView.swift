//
//  SignInView.swift
//  ReFix
//
//  Created by Ivan Laptii on 11.01.2024.
//

import SwiftUI

struct SignInView: View {
    enum Field: Hashable {
        case email
        case password
    }
    
    @EnvironmentObject private var viewModel: AuthViewModel
    @FocusState private var isFocused: Field?
    
    var body: some View {
        ZStack {
            VStack {
                appLogo
                signInTextFieldForm
                    .onTapGesture {}
                forgotPasswordButton
                unregisteredButton
                Spacer()
                signInButton
                    .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert, actions: {Button("Зрозуміло", role: .cancel){}})
                Spacer()
            }
            .background(Color(.secondarySystemBackground))
            .onTapGesture {
                isFocused = .none
            }
        }
    }
}

extension SignInView {
    var appLogo: some View {
        Image("AppLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 80)
            .padding(.top, 150)
    }
    
    var signInTextFieldForm: some View {
        VStack {
            Form {
                customTextFieldWithIcon(icon: "envelope.fill",
                    placeholder: "Пошта",
                    text: $viewModel.email
                )
                .focused($isFocused, equals: .email)
                
                customTextFieldWithIcon(
                    icon: "lock.fill",
                    placeholder: "Пароль",
                    text: $viewModel.password
                )
                .focused($isFocused, equals: .password)
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .frame(minHeight: 130, maxHeight: 150)
            .padding(.top, 100)
        }
    }
    
    func customTextFieldWithIcon(icon: String, placeholder: String, text: Binding<String>) -> some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
                .frame(width: 30)
            customTextField(placeholder: placeholder, text: text)
        }
    }
    
    func customTextField(placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .modifier(ClearButtonViewModifier(text: text))
    }
    
    var forgotPasswordButton: some View {
        Button("Забули пароль?") {
            Task {
                do {
                    try await viewModel.resetPassword(email: viewModel.email)
                } catch {
                    print(error)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    var unregisteredButton: some View {
        Button("Ще не зареєстровані?") {
            withAnimation {
                viewModel.authState = .signUp
            }
        }
        .padding(10)
        .buttonStyle(.borderless)
    }
    
    var signInButton: some View {
        Button ("Увійти") {
            Task {
                do {
                    try await viewModel.signIn()
                } catch {
                    print(error)
                    print(error.localizedDescription)

                }
            }
        }
        .padding(10)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    SignInView()
        .environmentObject(AuthViewModel())
}
