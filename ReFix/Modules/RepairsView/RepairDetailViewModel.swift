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
    
//    @Binding var isPresented: Bool
    
    init(repair: Repair) {
//        self._isPresented = isPresented
        self.id = repair.id
        self.brand = repair.brand
        self.model = repair.model
        self.serialNumber = repair.serialNumber
        self.imei = repair.imei
        self.malfunction = repair.malfunction
        self.description = repair.description
        self.client = repair.client
        self.employee = repair.employee
        self.repairStatus = repair.repairStatus
    }
    
//    func close() {
//        isPresented.toggle()
//    }
    
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
        
        RepairsManager.shared.updateReapair(user: user, updatedRepair: updatedRepair)
    }
}
