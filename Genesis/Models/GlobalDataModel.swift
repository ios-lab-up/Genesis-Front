//
//  GlobalDataModel.swift
//  Genesis
//
//  Created by Luis Cedillo M on 06/11/23.
//

import Foundation

class GlobalDataModel: ObservableObject {
    @Published var tabSelection: String = "1"
    @Published var tabSelectionDr: String = "1"
    static let shared = GlobalDataModel()
    @Published var user: User?
    @Published var userRelations: [User] = []
    @Published var userImages: [ImageData] = [] // Add this line to define userImages
    @Published var medicalHistory: [MedicalHistoryItem] = []
    @Published var chatMessages: [ChatMessage] = []
    @Published var userProfileImageUrl: String? // New variable for profile image URL

    


    
    
    private init() {} // Private initializer to enforce singleton usage
}
