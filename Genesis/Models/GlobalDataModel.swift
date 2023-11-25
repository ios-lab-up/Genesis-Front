//
//  GlobalDataModel.swift
//  Genesis
//
//  Created by Luis Cedillo M on 06/11/23.
//

import Foundation

class GlobalDataModel: ObservableObject {
    static let shared = GlobalDataModel()
    @Published var user: User?
    @Published var userRelations: [User] = []
    @Published var userImages: [ImageData] = [] // Add this line to define userImages
    @Published var medicalHistory: [MedicalHistoryItem] = []
    @Published var chatMessages: [ChatMessage] = []

    
    private init() {} // Private initializer to enforce singleton usage
}
