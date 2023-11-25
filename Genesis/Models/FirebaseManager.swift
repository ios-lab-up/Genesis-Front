//
//  FirebaseManager.swift
//  DermAware
//
//  Created by Luis Cedillo M on 24/11/23.
//

import Foundation
import FirebaseFirestore
import Firebase // Make sure Firebase is imported

final class FirebaseManager {
    
    // Singleton instance
    static let shared = FirebaseManager()

    // Private initializer for Singleton


    // Firestore reference
    private let db = Firestore.firestore()

    // Function to save username
    func saveUsername(completion: @escaping (Error?) -> Void) {
        // Firestore example
        db.collection("users").document(String(GlobalDataModel.shared.user?.id ?? 0)).setData(["username": GlobalDataModel.shared.user?.name ?? "N/A"], merge: true) { error in
            completion(error)
        }
    }
    
    // Function to save message
    func saveMessage(message: String,  toId: String, completion: @escaping (Error?) -> Void) {
        // Firestore example
        
        let fromId = String(GlobalDataModel.shared.user?.id ?? 0)
        
        let document = db.collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let messageData = ["fromId": fromId, "toId": toId, "text": message, "timestamp": Timestamp()] as [String : Any]
        
        document.setData(messageData) { error in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            print("Successfully saved current user sending message")
        }
        
        let recipientMessageDocument = db.collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        
        recipientMessageDocument.setData(messageData) { error in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            print("Recipient saved message as well")
            completion(nil)
        }
    }
    

    // Add other Firebase related functions here as needed
}
