import SwiftUI

// Define the ChatMessage model if not already defined

// ChatViewModel to interact with SocketHelper
class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    @Published var inputText = ""
    private let socketHelper = SocketHelper.shared
    var username: String
       var room: String
       
       init(username: String, room: String) {
           self.username = username
           self.room = room
           setupSocket()
       }
    func setupSocket() {
            socketHelper.connectSocket { [weak self] isConnected, error in
                if isConnected {
                    print("Socket connected")
                    self?.listenToMessages()
                } else if let error = error {
                    // Handle the error properly, e.g., show an error message to the user
                    print("Socket encountered an error: \(error.localizedDescription)")
                }
            }
        }
    
    func listenToMessages() {
        // Listen for new messages
        SocketHelper.Events.newMessage.listen { [weak self] data in
            guard let dataArray = data as? [[String: Any]], // Cast data to an array of dictionaries
                  let messageData = dataArray.first else { return } // Access the first element of the array

            if let text = messageData["text"] as? String,
               let userUidString = messageData["userUid"] as? String,
               let photoURL = messageData["photoURL"] as? String,
               let createdAtString = messageData["createdAt"] as? String,
               let createdAt = ISO8601DateFormatter().date(from: createdAtString) {
               
                let currentUserUidString = String(GlobalDataModel.shared.user?.id ?? 0) // Convert Int to String
                let isFromCurrentUser = userUidString == currentUserUidString
                
                let message = Message(userUid: userUidString, text: text, photoURL: photoURL, createdAt: createdAt, isFromCurrentUser: isFromCurrentUser)
                DispatchQueue.main.async {
                    self?.messages.append(message)
                    print("Message received: \(message)")
                }
            }

        }
    }





    // Call this method when the view appears
        func joinChatRoom() {
            socketHelper.joinRoom(username: username, room: room)
        }
        
        // Call this method when the view disappears
        func leaveChatRoom() {
            socketHelper.leaveRoom(username: username, room: room)
        }
    
    func sendMessage() {
        let messageData: [String: Any] = [
            "text": inputText,
            // Add other necessary data like 'userUid', 'photoURL', etc.
        ]
        SocketHelper.Events.newMessage.emit(params: messageData)
        inputText = ""
    }
    
    deinit {
        socketHelper.disconnectSocket()
    }
    
    
}

// ChatView to display and send messages
struct ChatView: View {

    @StateObject var viewModel = ChatViewModel(
        username: GlobalDataModel.shared.user?.username ?? "defaultUsername",
        room: String(GlobalDataModel.shared.medicalHistory.last?.associationId ?? 0) // Convert Int to String, replace 0 with a default room ID if needed
    )

    @Environment(\.presentationMode) var close


    var body: some View {
        VStack {
            HStack{
                Button(action:{
                    close.wrappedValue.dismiss()
                }){
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.black)
                    
                    Spacer()
                }
            }
            .padding()
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.messages) { message in
                        HStack {

                            if message.isFromCurrentUser {
                                Spacer()
                                Text(message.text)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            } else {
                                Text(message.text)
                                    .padding()
                                    .background(Color.gray)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                    }
                }
            }
            
            HStack {
                TextField("Type a message...", text: $viewModel.inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: viewModel.sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }.padding()
        }
        .navigationBarTitle("Chat", displayMode: .inline)
    }
}
