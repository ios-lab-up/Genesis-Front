//
//  MessageModel.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 23/10/23.
//

import Foundation


class Message {
    var userUid: String
    var text: String
    var photoURL: String
    var createdAt: Date

    init?(dictionary: [String: Any]) {
        guard let userUid = dictionary["userUid"] as? String,
              let text = dictionary["text"] as? String,
              let photoURL = dictionary["photoURL"] as? String,
              let createdAt = dictionary["createdAt"] as? Date else {
            return nil
        }
        self.userUid = userUid
        self.text = text
        self.photoURL = photoURL
        self.createdAt = createdAt
    }
}

