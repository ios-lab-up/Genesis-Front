//
//  ChatView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 23/10/23.
//

import SwiftUI
import SocketIO


class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    let manager: SocketManager
    var socket: SocketIOClient

    init() {
        self.manager = SocketManager(socketURL: URL(string: APIEndpoints.baseURL)!, config: [.log(true), .compress])
        self.socket = manager.defaultSocket

        socket.on(clientEvent: .connect) { data, ack in
            print("Socket connected")
        }

        socket.on("new_message") { [weak self] data, ack in
            guard let messageDict = data[0] as? [String: Any],
                  let message = Message(dictionary: messageDict) else {
                return
            }
            DispatchQueue.main.async {
                self?.messages.append(message)
            }
        }


        socket.connect()
    }

    func sendMessage(_ messageText: String) {
        socket.emit("chat_message", ["text": messageText])
    }
}

struct ChatView: View {
    @StateObject var chatViewModel = ChatViewModel()
    @State var text = ""

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(chatViewModel.messages) { message in
                        MessageView(message: message, isFromCurrentUser: message.isFromCurrentUser)
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
                                            chatViewModel.sendMessage(text)
                                            text = "" // Clear the text field after sending
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
        }.navigationBarTitle("Chat", displayMode: .inline)
    }
}



#Preview {
    ChatView()
}
