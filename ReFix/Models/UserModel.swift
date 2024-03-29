//
//  AuthDataResultModel.swift
//  ReFix
//
//  Created by Ivan Laptii on 16.01.2024.
//

import Foundation
import Firebase
import FirebaseAuth

struct UserModel {
    let uid: String
    let email: String?
    var companyName: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.companyName = ""
    }
}
