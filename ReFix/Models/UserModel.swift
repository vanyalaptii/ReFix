//
//  AuthDataResultModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 16.01.2024.
//

import Foundation
import Firebase
import FirebaseAuth

struct UserModel: Codable {
    let uid: String
    let email: String?
    var companyName: String
    
    enum CodingKeys: String, CodingKey {
        case uid
        case companyName = "company_name"
        case email
    }
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.companyName = ""
    }
}
