//
//  MessageView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 23/10/23.
//

import SwiftUI
struct MessageView: View {
    var message: Message
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if message.isFromCurrentUser {
                Spacer()
                messageBubble(fromCurrentUser: true)
            } else {
                messageBubble(fromCurrentUser: false)
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func messageBubble(fromCurrentUser: Bool) -> some View {
        HStack {
            Text(message.text)
                .padding()
                .foregroundColor(.white)
                .background(fromCurrentUser ? Color("Primary") : Color("textSecondary"))
                .cornerRadius(20)
        }
        .frame(maxWidth: 260, alignment: fromCurrentUser ? .trailing : .leading)
    }
}

// Usage (assuming you have logic to set isFromCurrentUser when initializing the message):
