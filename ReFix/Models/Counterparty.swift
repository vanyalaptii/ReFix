//
//  ConterAgent.swift
//  ReFix
//
//  Created by Ivan Laptii on 25.12.2023.
//

import Foundation

class Counterparty {
    let id: Int
    var name: String
    var surname: String
    var companyName: String
    var phoneNumber: String
    var email: String
    
    init(id: Int, name: String, surname: String, companyName: String, phoneNumber: String, email: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.companyName = companyName
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
}
