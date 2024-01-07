//
//  LoginView.swift
//  ReFix
//
//  Created by Ivan Laptii on 30.12.2023.
//

import SwiftUI

struct SignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            
            signInView
            
        }
        
        //TODO: login function
        
    }
}

extension SignInView {
    
    var logo: some View {
        Image("ReFixLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 80)
            .padding(.top, 150)
    }
    
    func row(icon: String, placeholder: String, text: Binding<String>) -> some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
                .frame(width: 30)
            TextField(placeholder, text: text)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }
    }
    
    var signInView: some View {
        VStack {
            
            logo
            
            Form {
                row(icon: "envelope.fill",
                    placeholder: "Пошта",
                    text: $email
                )
                row(
                    icon: "lock.fill",
                    placeholder: "Пароль",
                    text: $password
                )
            }
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .frame(height: 150)
            .padding(.top, 100)
            
            
            
            Button("Забули пароль?") {
                //TODO: navigation to forgot password
            }
            
                //TODO: navigation to sign up
            NavigationLink(destination: SignUpView(email: email), label: {
                Text("Ще не зареєстровані?")
            })
            .padding(.top)
            
            Spacer()
            
            Button ("Увійти") {
                
            }
            .padding(10)
            .foregroundStyle(.white)
            .background(.blue)
            .cornerRadius(10)
            
            Spacer()
            
        }
        .background(Color(.secondarySystemBackground))
        .ignoresSafeArea()
    }
}

#Preview {
    SignInView()
}
