//
//  AuthViewModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 11.01.2024.
//

import Foundation
import Firebase
import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    
    enum AuthState {
        case signIn
        case signUp
    }
    
    @Published var showAuthView: Bool = !AuthenticationManager.shared.isHaveLoggedUser()
    @Published var isFocused: Bool = false
    @Published var authState: AuthState = .signIn
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var companyName: String = ""
    
    func cleanUp() {
        email = ""
        password = ""
        passwordConfirmation = ""
        companyName = ""
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email or Password is empty.")
            return
        }
        guard email.contains("@") else {
            print("Email is not correct.")
            return
        }
        guard password.count >= 8 else {
            print("Password mismatch.")
            return
        }
        
        try await AuthenticationManager.shared.signIn(email: email, password: password)
        showAuthView = !AuthenticationManager.shared.isHaveLoggedUser()
        cleanUp()
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email or Password is empty.")
            return
        }
        guard password == passwordConfirmation else {
            print("Password mismatch.")
            return
        }
        guard email.contains("@") else {
            print("Email is not correct.")
            return
        }
        guard password.count >= 8 else {
            print("Password mismatch.")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
        showAuthView = !AuthenticationManager.shared.isHaveLoggedUser()
        cleanUp()
    }
    
    func resetPassword(email: String) async throws {
        //TODO: Provide a normal way to get a user email
    }
}
