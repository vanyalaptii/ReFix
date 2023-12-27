//
//  RepairCase.swift
//  ReFix
//
//  Created by Ivan Laptii on 23.12.2023.
//

import Foundation

class Repair: Identifiable {
    let id: Int
    var brand: String
    var model: String
    var serialNumber: String
    var imei: Int?
    var malfunction: String
    var description: String
    let client: Client
    let employee: String //Employee
    var repairStatus: String
    
    init(
        id: Int,
        brand: String,
        model: String,
        serialNumber: String,
        imei: Int?,
        malfunction: String,
        description: String,
        client: Client,
        employee: String,
        repairStatus: String
    ) {
        self.id = id
        self.brand = brand
        self.model = model
        self.serialNumber = serialNumber
        self.imei = imei
        self.malfunction = malfunction
        self.description = description
        self.client = client
        self.employee = employee
        self.repairStatus = repairStatus
    }
}

extension Repair {
    
    static let repairsMocked = [
        Repair(
            id: 1,
            brand: "Apple",
            model: "iPhone 13",
            serialNumber: "MK35HF754",
            imei: 432143214321123,
            malfunction: "Швидко розряджається",
            description: "Подряпини єкрану",
            client: Client(id: 1, name: "Микола", phoneNumber: "09768459327", email: "testmail@gmail.com"),
            employee: "Світлана",
            repairStatus: "Узгодження"),

        Repair(
            id: 2,
            brand: "Apple",
            model: "MacBook Pro 13",
            serialNumber: "MK354SYR4",
            imei: nil,
            malfunction: "Розбитий екран",
            description: "Потертості",
            client: Client(id: 2, name: "Іван Федорович", phoneNumber: "0682686451", email: "testmail2@gmail.com"),
            employee: "Олена",
            repairStatus: "Виконано")
    ]
    
}
