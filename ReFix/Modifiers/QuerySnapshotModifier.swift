//
//  QuerySnapshotModifier.swift
//  ReFix
//
//  Created by Ivan Laptii on 30.01.2024.
//

import Foundation
import FirebaseFirestore

extension QuerySnapshot {
    func decoded<Type: Decodable>() throws -> [Type] {
        let objects: [Type] = try documents.map({ try $0.decoded() })
        return objects
    }
}
