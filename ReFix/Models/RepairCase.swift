//
//  RepairCase.swift
//  ReFix
//
//  Created by Ваня Лаптий on 23.12.2023.
//

import Foundation

class RepairCase: Identifiable {
    let id: Int
    var brand: String
    var model: String
    var serialNumber: String
    var imei: Int?
    var malfunction: String
    var description: String
    let client: String //Client
    var telephone: String
    let employee: String //Employee
    var repairStatus: String //RepairStatus
    
    init(id: Int, brand: String, model: String, serialNumber: String, imei: Int?, malfunction: String, description: String, client: String, telephone: String, employee: String, repairStatus: String) {
        self.id = id
        self.brand = brand
        self.model = model
        self.serialNumber = serialNumber
        self.imei = imei
        self.malfunction = malfunction
        self.description = description
        self.client = client
        self.telephone = telephone
        self.employee = employee
        self.repairStatus = repairStatus
    }
}
