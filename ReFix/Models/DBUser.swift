//
//  DBUser.swift
//  ReFix
//
//  Created by Ivan Laptii on 25.01.2024.
//

import Foundation

struct DBUser: Codable {
    let userId: String
    let companyName: String?
    let email: String?
    let dateCreated: Date?
    
    init(user: UserModel) {
        self.userId = user.uid
        self.companyName = user.companyName
        self.email = user.email
        self.dateCreated = Date()
    }
}
