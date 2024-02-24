//
//  ClientsListViewModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 13.02.2024.
//

import Foundation

@MainActor
final class ClientsListViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    @Published internal var clientsListArray: [Client] = []
    
    @Published var searchText = ""
    @Published var searchIsActive = false
    @Published var isAddNewClientPresented: Bool = false

    var searchResults: [Client] {
        get {
            if searchText.isEmpty {
                return clientsListArray.sorted {$0.surname < $1.surname}
            } else {
                return clientsListArray
                    .filter { $0.name.lowercased().contains(searchText.lowercased()) }
                    .sorted {$0.surname < $1.surname}
                + clientsListArray
                    .filter { $0.surname.lowercased().contains(searchText.lowercased()) }
                    .sorted {$0.surname < $1.surname}
                + clientsListArray
                    .filter { $0.phoneNumber.contains(searchText) }
                    .sorted {$0.surname < $1.surname}
                + clientsListArray
                    .filter { $0.email.lowercased().contains(searchText.lowercased()) }
                    .sorted {$0.surname < $1.surname}
                //TODO: make possible to search by user name and phone number
            }
        }
        
        set {
            clientsListArray = newValue
        }
    }
    
    var futureClientId: Int {
        clientsListArray.count + 1
    }
    
    init() {
        Task(priority: .background){
            do {
                try await loadCurrentUser()
                try await loadClientsArray()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension ClientsListViewModel {
    private func loadCurrentUser() async throws {
        let userModel = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = DBUser(user: userModel)
    }
    
    private func loadClientsArray() async throws {
        guard let user = self.user else {
            print("Failed to download. No registered user!")
            return
        }
        do {
            self.clientsListArray = try await ClientsManager.shared.downloadAllClients(user: user)
        } catch {
            print(error.localizedDescription)
        }
    }
}
