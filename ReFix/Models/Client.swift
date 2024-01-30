//
//  Client.swift
//  ReFix
//
//  Created by Ivan Laptii on 25.12.2023.
//

import Foundation

class Client: Codable {
    let id: Int
    var name: String
    var phoneNumber: String
    var email: String
    
    init(id: Int, name: String, phoneNumber: String, email: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.email = try container.decode(String.self, forKey: .email)
    }
}
