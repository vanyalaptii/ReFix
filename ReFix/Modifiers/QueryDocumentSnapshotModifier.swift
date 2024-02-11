//
//  QueryDocumentSnapshotModifier.swift
//  ReFix
//
//  Created by Ivan Laptii on 30.01.2024.
//

import Foundation
import FirebaseFirestore

extension QueryDocumentSnapshot {
    func decoded<Type: Decodable>() throws -> Type {
        let data = try JSONSerialization.data(withJSONObject: data(), options: [])
        let object = try JSONDecoder().decode(Type.self, from: data)
        return object
    }
}
