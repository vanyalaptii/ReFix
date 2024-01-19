//
//  SignUpView.swift
//  ReFix
//
//  Created by Ivan Laptii on 11.01.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack {
            appLogo
            signUpTextFieldForm
            alreadyHaveAnAccountButton
            Spacer()
            registerButton
            Spacer()
        }
        .background(Color(.secondarySystemBackground))
        .onTapGesture {
            isFocused = false
        }
    }
}

extension SignUpView {
    var appLogo: some View {
        Image("AppLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 80)
            .padding(.top, 150)
    }
    
    func customTextField(placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .focused($isFocused)
            .modifier(ClearButtonViewModifier(text: text))
    }
    
    var signUpTextFieldForm: some View {
            Form {
                customTextField(placeholder: "Пошта", text: $viewModel.email)
                customTextField(placeholder: "Пароль", text: $viewModel.password)
                customTextField(placeholder: "Підтвердіть пароль", text: $viewModel.passwordConfirmation)
                customTextField(placeholder: "Ім'я компанії", text: $viewModel.companyName)
                    .textInputAutocapitalization(.sentences)
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .frame(minHeight: 210, maxHeight: 230)
            .padding(.top, 50)
        
    }
    
    var alreadyHaveAnAccountButton: some View {
        Button("Вже маєте обліковий запис?") {
            withAnimation {
                viewModel.authState = .signIn
            }
        }
        .padding(10)
        .buttonStyle(.borderless)
    }
    
    var registerButton: some View {
        Button ("Зареєструватись") {
            Task {
                do {
                    try await viewModel.signUp()
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
    SignUpView()
        .environmentObject(AuthViewModel())
}
