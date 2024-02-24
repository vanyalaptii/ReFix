//
//  ClientManager.swift
//  ReFix
//
//  Created by Ivan Laptii on 13.02.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ClientsManager {
    static let shared = ClientsManager()
    
    private let userCollection = Firestore.firestore().collection("users")
    private let clientsCollection = "clients"
    
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
    
    func createNewClient(user: DBUser, client: Client) throws {
        try userCollection.document(user.userId).collection(clientsCollection).document(client.id.description).setData(from: client, merge: true, encoder: encoder)
    }
    
    func updateClient(user: DBUser, updatedClient: Client) {
        userCollection.document(user.userId).collection(clientsCollection).document(updatedClient.id.description).updateData(
            [
                "name" : updatedClient.name,
                "surname" : updatedClient.surname,
                "phone_number" : updatedClient.phoneNumber,
                "email" : updatedClient.email,
            ]
        )
    }
    
    func clientsCounter(user: DBUser) async -> Int {
        var result: Int = 0
        do {
            let snapshot = try await userCollection.document(user.userId).collection(clientsCollection).count.getAggregation(source: .server)
            result = Int(truncating: snapshot.count)
        } catch {
            print(error.localizedDescription)
        }
        return result
    }
    
    func downloadAllClients(user: DBUser) async throws -> [Client] {
        var result: [Client] = []
        let snapshot = try await userCollection.document(user.userId).collection(clientsCollection).getDocuments()
        
        result = try snapshot.decoded()
        return result
    }
}
