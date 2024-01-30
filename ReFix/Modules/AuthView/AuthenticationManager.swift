//
//  AuthenticationManager.swift
//  ReFix
//
//  Created by Ivan Laptii on 14.01.2024.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init(){}
    
    func getAuthenticatedUser() throws -> UserModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return UserModel(user: user)
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> UserModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email.lowercased(), password: password)
        return UserModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signIn(email: String, password: String) async throws -> UserModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email.lowercased(), password: password)
        return UserModel(user: authDataResult.user)
        //TODO: Show alerts when user is not found
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email.lowercased())
    }
    
    //TODO: provide this functionality in future
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: password)
    }
    
    //TODO: provide this functionality in future
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.sendEmailVerification(beforeUpdatingEmail: email.lowercased())
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        
        try await user.delete()
    }
}
