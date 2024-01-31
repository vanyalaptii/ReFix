//
//  RepairCase.swift
//  ReFix
//
//  Created by Ivan Laptii on 23.12.2023.
//

import Foundation

class Repair: Identifiable, Codable {
    
    let id: Int
    var brand: String
    var model: String
    var serialNumber: String
    var imei: String
    var malfunction: String
    var description: String
    let client: String
    // TODO: Create Employee model
    let employee: String
    var repairStatus: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case brand
        case model
        case serialNumber = "serial_number"
        case imei
        case malfunction
        case description
        case client
        case employee
        case repairStatus = "repair_status"
      }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.brand = try container.decode(String.self, forKey: .brand)
        self.model = try container.decode(String.self, forKey: .model)
        self.serialNumber = try container.decode(String.self, forKey: .serialNumber)
        self.imei = try container.decode(String.self, forKey: .imei)
        self.malfunction = try container.decode(String.self, forKey: .malfunction)
        self.description = try container.decode(String.self, forKey: .description)
        self.client = try container.decode(String.self, forKey: .client)
        self.employee = try container.decode(String.self, forKey: .employee)
        self.repairStatus = try container.decode(String.self, forKey: .repairStatus)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(brand, forKey: .brand)
        try container.encode(model, forKey: .model)
        try container.encode(serialNumber, forKey: .serialNumber)
        try container.encodeIfPresent(imei, forKey: .imei)
        try container.encode(malfunction, forKey: .malfunction)
        try container.encode(description, forKey: .description)
        try container.encode(client, forKey: .client)
        try container.encode(employee, forKey: .employee)
        try container.encode(repairStatus, forKey: .repairStatus)
    }
    
    
    
    init(
        id: Int,
        brand: String,
        model: String,
        serialNumber: String,
        imei: String,
        malfunction: String,
        description: String,
        client: String,
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
            imei: "432143214321123",
            malfunction: "Швидко розряджається",
            description: "Подряпини єкрану",
            client: "Микола", //Client(id: 1, name: "Микола", phoneNumber: "09768459327", email: "testmail@gmail.com"),
            employee: "Світлана",
            repairStatus: "Узгодження"),

        Repair(
            id: 2,
            brand: "Apple",
            model: "MacBook Pro 13",
            serialNumber: "MK354SYR4",
            imei: "",
            malfunction: "Розбитий екран",
            description: "Потертості",
            client: "Іван Федорович", //Client(id: 2, name: "Іван Федорович", phoneNumber: "0682686451", email: "testmail2@gmail.com"),
            employee: "Олена",
            repairStatus: "Виконано")
    ]
    
}
