//
//  MessageModel.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 23/10/23.
//

import Foundation


struct Message {
    var userUid: String
    var text: String
    var photoURL: String
    var createdAt: Date
    var isFromCurrentUser: Bool

    init(userUid: String, text: String, photoURL: String, createdAt: Date, isFromCurrentUser: Bool) {
        self.userUid = userUid
        self.text = text
        self.photoURL = photoURL
        self.createdAt = createdAt
        self.isFromCurrentUser = isFromCurrentUser
    }

    init?(dictionary: [String: Any]) {
        guard let userUid = dictionary["userUid"] as? String,
              let text = dictionary["text"] as? String,
              let photoURL = dictionary["photoURL"] as? String,
              let createdAt = dictionary["createdAt"] as? Date else {
            return nil
        }
        self.init(userUid: userUid, text: text, photoURL: photoURL, createdAt: createdAt, isFromCurrentUser: false) // Determine isFromCurrentUser based on your logic
    }
}
