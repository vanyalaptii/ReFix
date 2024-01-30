//
//  RepairsManager.swift
//  ReFix
//
//  Created by Ivan Laptii on 25.01.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class RepairsManager {
    
    static var shared = RepairsManager()
    
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewRepair(user: DBUser, repair: Repair) throws {
        try userCollection.document(user.userId).collection("repairs").document(repair.id.description).setData(from: repair, merge: true, encoder: encoder)
    }
    
    func repairsCounter(user: DBUser) async -> Int {
        var result: Int = 0
        do {
            let snapshot = try await userCollection.document(user.userId).collection("repairs").count.getAggregation(source: .server)
            result = Int(truncating: snapshot.count)
        } catch {
            print(error.localizedDescription)
        }
        return result
    }
    
    func downloadAllRepairs(user: DBUser) async -> [Repair]{
        var result: [Repair] = []
        let snapshot = try await userCollection.document(user.userId).collection("repairs").getDocuments { snapshot, _ in
//            let documents = snapshot!.documents
//            try! documents.forEach { document in
//                let repair: Repair = try document.decoded()
//                result.append(repair)
//            }
            
            result = try! snapshot!.decoded()
            result.forEach({ print($0) })
        }
        return result
    }
}
