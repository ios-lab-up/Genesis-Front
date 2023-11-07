//
//  MessageModel.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 23/10/23.
//

import Foundation


struct Message: Decodable, Identifiable {
    let id = UUID()
    let userUid: String
    let text: String
    let photoURL: String
    let createdAt: Date
    
    
    func isFromCurrentUser() -> Bool {
        return true
    }
}
