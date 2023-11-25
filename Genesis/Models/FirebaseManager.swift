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
        db.collection("users").document(GlobalDataModel.shared.user?.email ?? "N/A" ).setData(["username": GlobalDataModel.shared.user?.name ?? "N/A"], merge: true) { error in
            completion(error)
        }
    }

    // Add other Firebase related functions here as needed
}
