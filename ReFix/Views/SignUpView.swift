//
//  SignUpView.swift
//  ReFix
//
//  Created by Ivan Laptii on 06.01.2024.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirmation: String = ""
    @State var companyName: String = ""
    @State var userIsLoggedIn = false
    
    var body: some View {
        
        if userIsLoggedIn {
            MainView()
        } else {
            signUpView
        }
        
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

extension SignUpView {
    
    var logo: some View {
        Image("ReFixLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 80)
            .padding(.top, 150)
    }
    
    func row(placeholder: String, text: Binding<String>) -> some View {
            TextField(placeholder, text: text)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
    }
    
    var signUpView: some View {
        VStack {
            
            logo
            
            Form {
                
                row(placeholder: "Пошта", text: $email)
                
                row(placeholder: "Пароль", text: $password)
                
                row(placeholder: "Підтвердіть пароль", text: $passwordConfirmation)
                
                row(placeholder: "Ім'я компанії", text: $companyName)
                    .textInputAutocapitalization(.sentences)
                
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .frame(height: 230)
            .padding(.top, 50)
            
            //TODO: navigation to Sign In
            NavigationLink(destination: SignInView(email: email), label: {
                Text("Вже маєте обліковий запис?")
                    .foregroundStyle(.blue)
            })
            
            Spacer()
            
            Button ("Зареєструватись") {
                register()
            }
            .padding(10)
            .foregroundStyle(.white)
            .background(.blue)
            .cornerRadius(10)
            
            Spacer()
        }
        .background(Color(.secondarySystemBackground))
        .ignoresSafeArea()
        .onTapGesture {
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    userIsLoggedIn.toggle()
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}
