//
//  Client.swift
//  ReFix
//
//  Created by Ivan Laptii on 25.12.2023.
//

import Foundation

class Client: Identifiable, Codable {
    let id: Int
    var name: String
    var surname: String
    var phoneNumber: String
    var email: String
    
    init(id: Int, 
         name: String,
         surname: String,
         phoneNumber: String,
         email: String
    ) {
        self.id = id
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case surname
        case phoneNumber = "phone_number"
        case email
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.surname = try container.decode(String.self, forKey: .surname)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.email = try container.decode(String.self, forKey: .email)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(surname, forKey: .surname)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encodeIfPresent(email, forKey: .email)
    }
}

extension Client {
    
    static let cliendtsMocked = [
        Client(
            id: 1,
            name: "Богдан",
            surname: "Федоров",
            phoneNumber: "0976452374",
            email: "bogdan@mail.com"),

        Client(
            id: 2,
            name: "Андрій",
            surname: "Федосов",
            phoneNumber: "0976538574",
            email: "andriy@mail.com"),
        
        Client(
            id: 3,
            name: "Роман",
            surname: "Слободянюк",
            phoneNumber: "0976452374",
            email: "bogdan@mail.com"),
    ]
}
