//
//  RepairsListViewModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 25.01.2024.
//

import Foundation

@MainActor
final class RepairsListViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    @Published internal var repairListArray: [Repair] = []
    
    @Published var searchText = ""
    @Published var searchIsActive = false
    @Published var isAddNewRepairPresented: Bool = false
    
    var searchResults: [Repair] {
        get {
            if searchText.isEmpty {
                return repairListArray.sorted { $0.id > $1.id }
            } else {
                return searchResult()
            }
        }
        
        set {
            repairListArray = newValue
        }
    }
    
    init() {
        Task{
            try await loadCurrentUser()
            try await loadRepairsArray()
        }
    }
    
    var futureRepairId: Int {
        repairListArray.count + 1
    }
    
    func loadCurrentUser() async throws {
        let userModel = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: userModel.uid)
    }
    
    func loadRepairsArray() async throws {
        guard let user = self.user else {
            print("Failed to download. No registered user!")
            return
        }
        do {
            self.repairListArray = try await RepairsManager.shared.downloadAllRepairs(user: user)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension RepairsListViewModel {
    private func searchResult() -> [Repair] {
        return repairListArray
            .filter { $0.model.contains(searchText) }
            .sorted { $0.id > $1.id }
        + repairListArray
            .filter { $0.brand.contains(searchText) }
            .sorted { $0.id > $1.id }
        + repairListArray
            .filter { $0.id.description.contains(searchText) }
            .sorted { $0.id > $1.id }
        + repairListArray
            .filter { $0.imei.description.contains(searchText) }
            .sorted { $0.id > $1.id }
        + repairListArray
            .filter { $0.serialNumber.description.contains(searchText) }
            .sorted { $0.id > $1.id }
        //TODO: make possible to search by user name and phone number
    }
}
