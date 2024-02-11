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
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isUserLoggedIn: Bool = false
    @Published var tabSelection: String = "first"
    @Published var authState: AuthState = .signIn
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var companyName: String = ""
    
    init() {
        withAnimation {
            self.isUserLoggedIn = findLoggedUser()
        }
    }
    
    func findLoggedUser() -> Bool {
        let user = try? AuthenticationManager.shared.getAuthenticatedUser()
        return user != nil ? true : false
    }
    
    func cleanUp() {
        email = ""
        password = ""
        passwordConfirmation = ""
        companyName = ""
    }
    
    func focusOn(screen tag: String) {
        tabSelection = tag
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            let result = "Email or password is empty."
            showAlert = true
            alertMessage = result
            return
        }
        guard email.contains("@") else {
            let result = "Email is not correct."
            showAlert = true
            alertMessage = result
            return
        }
        guard password.count >= 8 else {
            let result = "Password mismatch."
            showAlert = true
            alertMessage = result
            return
        }
        do {
            try await AuthenticationManager.shared.signIn(email: email, password: password)
        } catch {
            showAlert = true
            alertMessage = error.localizedDescription
        }
        withAnimation {
            isUserLoggedIn = findLoggedUser()
            cleanUp()
        }
        focusOn(screen: "Repairs")
        return 
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            let result = "Email or password is empty."
            showAlert = true
            alertMessage = result
            return
        }
        guard password == passwordConfirmation else {
            let result = "Password mismatch."
            showAlert = true
            alertMessage = result
            return
        }
        guard email.contains("@") else {
            let result = "Email is not correct."
            showAlert = true
            alertMessage = result
            return
        }
        guard password.count >= 8 else {
            let result = "Password mismatch."
            showAlert = true
            alertMessage = result
            return
        }
        guard !companyName.isEmpty else {
            let result = "Company name is empty."
            showAlert = true
            alertMessage = result
            return
        }
        
        do {
            try await AuthenticationManager.shared.createUser(email: email, password: password)
        } catch {
            showAlert = true
            alertMessage = error.localizedDescription
        }
        var authResult = try AuthenticationManager.shared.getAuthenticatedUser()
        authResult.companyName = companyName
        let user = DBUser(user: authResult)
        try UserManager.shared.createNewUser(user: user)
        //try RepairsManager.shared.createNewRepair(user: user, repair: Repair.repairsMocked[1]) //!
        withAnimation {
            isUserLoggedIn = findLoggedUser()
            cleanUp()
        }
        focusOn(screen: "Repairs")
    }
    
    func resetPassword(email: String) async throws {
        //TODO: Provide a normal way to get a user email
    }
}
