//
//  SignUpView.swift
//  ReFix
//
//  Created by Ivan Laptii on 11.01.2024.
//

import SwiftUI

struct SignUpView: View {
    enum Field: Hashable {
        case email
        case password
        case comfirmPassword
        case companyName
    }
    
    @EnvironmentObject var viewModel: AuthViewModel
    @FocusState var isFocused: Field?
    
    var body: some View {
        VStack {
            appLogo
            signUpTextFieldForm
                .onTapGesture {}
            alreadyHaveAnAccountButton
            Spacer()
            registerButton
                .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert, actions: {Button("Зрозуміло", role: .cancel){}})
            Spacer()
        }
        .background(Color(.secondarySystemBackground))
        .onTapGesture {
            isFocused = .none
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
            .modifier(ClearButtonViewModifier(text: text))
    }
    
    var signUpTextFieldForm: some View {
            Form {
                customTextField(placeholder: "Пошта", text: $viewModel.email)
                    .focused($isFocused, equals: .email)
                customTextField(placeholder: "Пароль", text: $viewModel.password)
                    .focused($isFocused, equals: .password)
                customTextField(placeholder: "Підтвердіть пароль", text: $viewModel.passwordConfirmation)
                    .focused($isFocused, equals: .comfirmPassword)
                customTextField(placeholder: "Ім'я компанії", text: $viewModel.companyName)
                    .focused($isFocused, equals: .companyName)
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
