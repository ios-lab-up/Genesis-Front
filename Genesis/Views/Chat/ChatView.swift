//
//  ChatView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 23/10/23.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    
    static let mockData: [Message] = [
        Message(userUid: "user001", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", photoURL: "https://example.com/photo1.jpg", createdAt: Date()),
        Message(userUid: "user002", text: "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", photoURL: "https://example.com/photo2.jpg", createdAt: Date()),
        Message(userUid: "user003", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", photoURL: "https://example.com/photo3.jpg", createdAt: Date()),
        Message(userUid: "user004", text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.", photoURL: "https://example.com/photo4.jpg", createdAt: Date()),
        Message(userUid: "user005", text: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", photoURL: "https://example.com/photo5.jpg", createdAt: Date()),
        Message(userUid: "user006", text: "Nullam ac tortor vitae purus faucibus ornare suspendisse sed.", photoURL: "https://example.com/photo6.jpg", createdAt: Date()),
    ]

}

struct ChatView: View {
    @StateObject var chatViewModel = ChatViewModel()
    @State var text = ""

    var body: some View {
        VStack {
            ScrollView{
                VStack(spacing: 8){
                    ForEach(ChatViewModel.mockData){
                        message in
                        MessageView(message: message)
                    }
                }
            }

            HStack {
                TextField("Type a message...", text: $text)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                            .background(
                                ZStack {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            // Send action here
                                            print("Send tapped!")
                                        }) {
                                            Image(systemName: "arrow.up.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(Color.blue)
                                                .padding(.trailing, 12)
                                        }
                                    }
                                }
                            )
                    )
                    .padding(.horizontal, 10)
            }
           
        
        }.navigationBarTitle("Chat", displayMode: .inline) // Set the navigation bar title for ChatView
    }
    }

#Preview {
    ChatView()
}
