//
//  ProfileViewModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 15.01.2024.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    
    init() {
        Task {
            try await loadCurrentUser()
        }
    }
    
    func loadCurrentUser() async throws {
        let userModel = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: userModel.uid)
    }
    
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
