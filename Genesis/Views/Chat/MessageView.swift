//
//  MessageView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 23/10/23.
//

import SwiftUI

struct MessageView: View {
    var message: Message
    var isFromCurrentUser: Bool = false
    var body: some View {
        if message.isFromCurrentUser() {
            HStack{
                
                HStack{
                    Text(message.text)
                        .padding()
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 260, alignment: .topLeading)
                .background(Color("Primary"))
                .cornerRadius(20)
                
                /*Image(systemName: "person")
                    .frame(maxHeight: 32)
                    .padding(.leading, 4)*/
            }
            .frame(maxWidth: 360, alignment: .trailing)
            
        } else {
            HStack{
                Image(systemName: "person")
                    .frame(maxHeight: 32)
                    .padding(.trailing, 4)
                HStack{
                    Text(message.text)
                        .padding()
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 260, alignment: .leading)
                .background(Color("textSecondary"))
                .cornerRadius(15)
            }
            .frame(maxWidth: 360, alignment: .leading)
        }
    }
}

#Preview {
    MessageView(message: Message(userUid: "123", text: "Hello, World", photoURL: "", createdAt: Date()))
}
