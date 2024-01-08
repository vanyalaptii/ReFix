//
//  LoginView.swift
//  ReFix
//
//  Created by Ivan Laptii on 30.12.2023.
//

import SwiftUI
import Firebase


struct AuthView: View {
    
    enum AuthState {
        case signIn
        case signUp
    }
    
    @State private var authState: AuthState = .signIn
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var companyName: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                logo
                if authState == .signIn {
                    signInTextFieldForm
                    forgotPasswordButton
                    unregisteredButton
                    Spacer()
                    signInButton
                    Spacer()
                } else if authState == .signUp {
                    signUpTextFieldForm
                    alreadyHaveAnAccountButton
                    Spacer()
                    registerButton
                    Spacer()
                }
            }
            .background(Color(.secondarySystemBackground), ignoresSafeAreaEdges: .all)
            .ignoresSafeArea()
            .onTapGesture {
                isFocused = false
            }
        }
    }
    
    //TODO: login function
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

extension AuthView {
    var logo: some View {
        Image("AppLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 80)
            .padding(.top, 150)
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
            .focused($isFocused)
            .modifier(ClearButtonViewModifier(text: text))
    }
    
    var signInTextFieldForm: some View {
        VStack {
            Form {
                customTextFieldWithIcon(icon: "envelope.fill",
                    placeholder: "Пошта",
                    text: $email
                )
                customTextFieldWithIcon(
                    icon: "lock.fill",
                    placeholder: "Пароль",
                    text: $password
                )
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .frame(minHeight: 130, maxHeight: 150)
            .padding(.top, 100)
        }
    }
    
    var signUpTextFieldForm: some View {
            Form {
                customTextField(placeholder: "Пошта", text: $email)
                customTextField(placeholder: "Пароль", text: $password)
                customTextField(placeholder: "Підтвердіть пароль", text: $passwordConfirmation)
                customTextField(placeholder: "Ім'я компанії", text: $companyName)
                    .textInputAutocapitalization(.sentences)
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .frame(minHeight: 210, maxHeight: 230)
            .padding(.top, 50)
        
    }
    
    var forgotPasswordButton: some View {
        Button("Забули пароль?") {
            //TODO: navigation to forgot password
        }
    }
    
    var unregisteredButton: some View {        
        Button("Ще не зареєстровані?") {
            withAnimation {
                authState = .signUp
            }
        }
        .padding(10)
        .buttonStyle(.borderless)
    }
    
    var signInButton: some View {
        Button ("Увійти") {
        }
        .padding(10)
        .buttonStyle(.borderedProminent)
    }
    
    var alreadyHaveAnAccountButton: some View {
        Button("Вже маєте обліковий запис?") {
            withAnimation {
                authState = .signIn
            }
        }
        .padding(10)
        .buttonStyle(.borderless)
    }
    
    var registerButton: some View {
        Button ("Зареєструватись") {
            register()
        }
        .padding(10)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    AuthView()
}
