//
//  AuthViewModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 11.01.2024.
//

import Foundation
import Firebase
import SwiftUI

final class AuthViewModel: ObservableObject {
    enum AuthState {
        case signIn
        case signUp
    }
    
    @Published var isFocused: Bool = false
    @Published var authState: AuthState = .signIn
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var companyName: String = ""
    
    
    func login() {
        //TODO: login function
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func focusOff() {
        isFocused = false
    }
    
}
