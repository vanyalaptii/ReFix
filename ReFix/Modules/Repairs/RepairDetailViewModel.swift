//
//  RepairDetailViewModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 31.01.2024.
//

import Foundation
import SwiftUI

@MainActor
final class RepairDetailViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    
    @Published public var repair: Binding<Repair>
    
    @Published var id: Int
    @Published var brand: String = ""
    @Published var model: String = ""
    @Published var serialNumber: String = ""
    @Published var imei: String = ""
    @Published var malfunction: String = ""
    @Published var description: String = ""
    @Published var client: String = ""
    @Published var employee: String = ""
    @Published var repairStatus: String = ""
    
    init(repair: Binding<Repair>) {
        
        self.repair = repair
        
        self.id = repair.wrappedValue.id
        self.brand = repair.wrappedValue.brand
        self.model = repair.wrappedValue.model
        self.serialNumber = repair.wrappedValue.serialNumber
        self.imei = repair.wrappedValue.imei
        self.malfunction = repair.wrappedValue.malfunction
        self.description = repair.wrappedValue.description
        self.client = repair.wrappedValue.client
        self.employee = repair.wrappedValue.employee
        self.repairStatus = repair.wrappedValue.repairStatus
    }
    
    func discardUnsavedValues() {
        self.id = repair.wrappedValue.id
        self.brand = repair.wrappedValue.brand
        self.model = repair.wrappedValue.model
        self.serialNumber = repair.wrappedValue.serialNumber
        self.imei = repair.wrappedValue.imei
        self.malfunction = repair.wrappedValue.malfunction
        self.description = repair.wrappedValue.description
        self.client = repair.wrappedValue.client
        self.employee = repair.wrappedValue.employee
        self.repairStatus = repair.wrappedValue.repairStatus
    }
    
    func loadCurrentUser() async throws {
        let userModel = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: userModel.uid)
    }
    
    func updateRepair() async throws {
        try await loadCurrentUser()
        guard let user = self.user else { return }
        
        let updatedRepair = Repair(
            id: self.id,
            brand: self.brand,
            model: self.model,
            serialNumber: self.serialNumber,
            imei: self.imei,
            malfunction: self.malfunction,
            description: self.description,
            client: self.client,
            employee: self.employee,
            repairStatus: self.repairStatus
        )
        
        repair.wrappedValue = updatedRepair
        
        RepairsManager.shared.updateReapair(user: user, updatedRepair: updatedRepair)
    }
}
