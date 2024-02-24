//
//  AddNewClientViewModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 13.02.2024.
//

import Foundation
import SwiftUI

@MainActor
final class AddNewClientViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    @Published var clientDatailIsPresented: Bool = false
    @Binding private(set) var clientListArray: [Client]
    @Binding var isAddNewClientPresented: Bool
    
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    
    init(addNewClientState: Binding<Bool>, clientListArray: Binding<[Client]>){
        self._isAddNewClientPresented = addNewClientState
        self._clientListArray = clientListArray
        Task {
            try await loadCurrentUser()
        }
    }
    
    var futureClientId: Int {
        clientListArray.count + 1
    }
    
    func loadCurrentUser() async throws {
        let userModel = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = DBUser(user: userModel)
    }
    
    func addNewClient() async {
        guard let user = self.user else { return }
        
        let newClientId: Int = await ClientsManager.shared.clientsCounter(user: user) + 1
        
        let newClient = Client(id: newClientId,
                            name: self.name,
                            surname: self.surname,
                            phoneNumber: self.phoneNumber,
                            email: self.email
        )
        
        do {
            try ClientsManager.shared.createNewClient(user: user, client: newClient)
        } catch {
            print(error.localizedDescription)
            return
        }
        clientListArray.append(newClient)
        isAddNewClientPresented.toggle()
        cleanFields()
    }
    
    func cleanFields() {
        self.name = ""
        self.surname = ""
        self.phoneNumber = ""
        self.email = ""
    }
}
