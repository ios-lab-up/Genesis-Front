//
//  MessageView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 23/10/23.
//

import SwiftUI
struct MessageView: View {
    let message: ChatMessage
    let isCurrentUser: Bool

    var body: some View {
        HStack {
                   if isCurrentUser {
                       Spacer()
                   }
                   
                   Text(message.text)
                .foregroundColor(isCurrentUser ? .white: Color("blackish"))
                       .padding(12)
                       .background(isCurrentUser ? Color("Primary") : Color.gray.opacity(0.5))
                       .cornerRadius(100)
                       .frame(maxWidth: 250, alignment: isCurrentUser ? .trailing : .leading)
                   
                   if !isCurrentUser {
                       Spacer()
                   }
               }
               .padding(isCurrentUser ? .leading : .trailing, 60)
               .padding(.vertical, 5)
        .padding(isCurrentUser ? .leading : .trailing, 60)
        .padding(.vertical, 5)
        // ... (Cualquier otro código necesario para tu MessageView) ...
    }
}


// Usage (assuming you have logic to set isFromCurrentUser when initializing the message):
