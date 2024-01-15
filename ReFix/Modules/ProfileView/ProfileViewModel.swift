//
//  ProfileViewModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 15.01.2024.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    func updatePassword() async throws {
        //TODO: Provide a normal way to get a user email
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let _ = authUser.email else {
            throw URLError(.userAuthenticationRequired)
        }
        let password = "11111111"
        try await AuthenticationManager.shared.updatePassword(password: password)
        print("Password reset!")
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.deleteAccount()
    }
}
