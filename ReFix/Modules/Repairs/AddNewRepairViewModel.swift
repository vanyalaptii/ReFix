//
//  AddNewRepairViewModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 07.02.2024.
//

import Foundation
import SwiftUI

@MainActor
final class AddNewRepairViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published var repairDatailIsPresented: Bool = false
    @Binding private(set) var repairListArray: [Repair]
    @Binding var addNewRepairIsPresented: Bool
    
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
    
    init(addNewRepairState: Binding<Bool>, repairListArray: Binding<[Repair]>){
        self._addNewRepairIsPresented = addNewRepairState
        self._repairListArray = repairListArray
        Task {
            try await loadCurrentUser()
        }
    }
    
    var futureRepairId: Int {
        repairListArray.count + 1
    }
    
    func loadCurrentUser() async throws {
        let userModel = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: userModel.uid)
    }
    
    func addNewRepair() async {
        guard let user = self.user else { return }
        
        let newRepairId: Int = await RepairsManager.shared.repairsCounter(user: user) + 1
        
        let newRepair = Repair(id: newRepairId,
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
            try RepairsManager.shared.createNewRepair(user: user, repair: newRepair)
        } catch {
            print(error.localizedDescription)
            return
        }
        repairListArray.append(newRepair)
        addNewRepairIsPresented.toggle()
        cleanFields()
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
}
