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
    @Published private(set) var repairListArray: [Repair] = []
    
    @Published var addNewRepairIsPresented: Bool = false
    
    @Published var brand: String = ""
    @Published var model: String = ""
    @Published var serialNumber: String = ""
    @Published var imei: String = ""
    @Published var malfunction: String = ""
    @Published var description: String = ""
    @Published var client: String = ""
    @Published var phoneNumber: String = ""
    @Published var conteragent: String = ""
    @Published var employee: String = ""
    
    func loadCurrentUser() async throws {
        let userModel = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: userModel.uid)
    }
    
    func cleanFields() {
        self.brand = ""
        self.model = ""
        self.serialNumber = ""
        self.imei = ""
        self.malfunction = ""
        self.description = ""
        self.client = ""
        self.phoneNumber = ""
        self.conteragent = ""
        self.employee = ""
    }
    
    func addNewRepair() async {
        guard let user = self.user else { return }
        
        var newReapairId: Int = await RepairsManager.shared.repairsCounter(user: user) + 1
        
        let repair = Repair(id: newReapairId,
                            brand: self.brand,
                            model: self.model,
                            serialNumber: self.serialNumber,
                            imei: self.imei,
                            malfunction: self.malfunction,
                            description: self.description,
                            client: self.client,
                            employee: self.employee,
                            repairStatus: "Замовлення прийнято"
        )
        
        do {
            try RepairsManager.shared.createNewRepair(user: user, repair: repair)
        } catch {
            print(error.localizedDescription)
        }
        
        addNewRepairIsPresented.toggle()
        cleanFields()
    }
    
    func loadRepairsArray() async {
        guard let user = self.user else {
            print("Failed todownload. No registered user!")
            return
        }
        self.repairListArray = await RepairsManager.shared.downloadAllRepairs(user: user)
    }
}
