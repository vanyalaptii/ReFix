//
//  ConterAgent.swift
//  ReFix
//
//  Created by Ivan Laptii on 25.12.2023.
//

import Foundation

class ConterAgent {
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
}
