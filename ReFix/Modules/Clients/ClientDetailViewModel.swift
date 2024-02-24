//
//  ClientDetailViewModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 16.02.2024.
//

import Foundation
import SwiftUI

@MainActor
final class ClientDetailViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    
    @Published public var client: Binding<Client>
    
    @Published private var id: Int
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    
    init(client: Binding<Client>) {
        self.client = client
        self.id = client.wrappedValue.id
        self.name = client.wrappedValue.name
        self.surname = client.wrappedValue.surname
        self.phoneNumber = client.wrappedValue.phoneNumber
        self.email = client.wrappedValue.email
    }
    
    func cleanAllTextFields() {
        self.id = client.wrappedValue.id
        self.name = client.wrappedValue.name
        self.surname = client.wrappedValue.surname
        self.phoneNumber = client.wrappedValue.phoneNumber
        self.email = client.wrappedValue.email
    }
    
    func updateRepair() async throws {
        try await loadCurrentUser()
        guard let user = self.user else { return }
        
        let updatedClient = Client(
            id: self.id,
            name: self.name,
            surname: self.surname,
            phoneNumber: self.phoneNumber,
            email: self.email
        )
        
        client.wrappedValue = updatedClient
        
        ClientsManager.shared.updateClient(user: user, updatedClient: updatedClient)
    }
}

extension ClientDetailViewModel {
    private func loadCurrentUser() async throws {
        let userModel = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = DBUser(user: userModel)
    }
}
