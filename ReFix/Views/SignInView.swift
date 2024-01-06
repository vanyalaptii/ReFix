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
        ZStack {
            
            Color(.secondarySystemBackground)
            
            VStack {
                
                Image("ReFixLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 80)
                    .offset(y: -80)
                
                Form {
                        HStack {
                            Image(systemName: "envelope.fill")
                            TextField("Пошта", text: $email)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        }
                            
                        HStack {
                            Image(systemName: "lock.fill")
                                .offset(x: 2)
                            SecureField("Пароль", text: $password)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                                .offset(x: 7)
                        }
                }
                .frame(height: 150)
                
                //TODO: navigation to forgot password
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Забули пароль?")
                })
                .padding(.bottom)
                
                //TODO: navigation to sign up
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Ще не зареєстровані?")
                })
                .padding(.bottom)
                
                Button {} label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                        Text("Увійти")
                            .foregroundStyle(.white)
                    }
                    .frame(width: 90, height: 40)
                }
                .offset(y: 150)
            }
        }
        .ignoresSafeArea()
    }
    
    //TODO: login function
     
}

#Preview {
    SignInView()
}
