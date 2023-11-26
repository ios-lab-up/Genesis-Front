import SwiftUI
import FirebaseFirestore


struct FirebaseConstants{
    static let fromId = "fromId"
    static let toId = "toId"
    static let text = "text"
}

// Define the ChatMessage model if not already defined
struct ChatMessage: Identifiable {
    
    var id: String { documentId }
    
    let documentId: String
    let fromId, toId, text: String
    let timestamp: Date


    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
        if let timestamp = data["timestamp"] as? Timestamp {
            self.timestamp = timestamp.dateValue()
        } else {
            self.timestamp = Date() // Default to current date if not available
        }
    }
    
}


// ChatView to display and send messages
struct ChatView: View {
    
    @State private var chatText = ""
    @State private var messages = [ChatMessage]()
    @ObservedObject private var globalData = GlobalDataModel.shared
    
    let userChat = GlobalDataModel.shared.userRelations.first
    
    @Environment(\.presentationMode) var close
    
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    // Use the 'messages' state array here
                    ForEach(messages) { message in
                        HStack{
                            Spacer()
                            HStack{
                                Text(message.text)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color("Primary"))
                            .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                    HStack{Spacer()}
                }
                .background(Color(.init(white:0.95, alpha:1)))
                HStack(spacing: 16){
                    Image(systemName: "photo.on.rectangle")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                    ZStack{
                        DescriptionPlaceholder()
                        TextEditor(text: $chatText)
                            .opacity(chatText.isEmpty ? 0.5:1)
                    }
                    .frame(height: 40)
                    
                    Button {
                        let message = chatText // Capture the current chat text
                        if let toId = userChat?.id { // Safely unwrap the optional userChat ID
                            FirebaseManager.shared.saveMessage(message: message, toId: String(toId)) { error in
                                DispatchQueue.main.async {
                                    if let error = error {
                                        print("Error saving message: \(error.localizedDescription)")
                                    } else {
                                        chatText = "" // Reset chatText on the main thread
                                        print("Successfully saved message")
                                    }
                                }
                            }
                        }
                    } label: {
                        Text("Send")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color("Primary"))
                    .cornerRadius(8)
                    
                    
                    
                    
                }.toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button(action:{
                            close.wrappedValue.dismiss()
                        }){
                            HStack{
                                Image(systemName: "chevron.left")
                                    .font(.callout)
                                    .bold()
                                
                                
                            }
                            
                            
                        }
                    }
                }
                .navigationTitle(userChat?.name ?? "Chat")
                .navigationBarTitleDisplayMode(.inline)
            }.onAppear{
                // Fetch messages when the view appears
                fetchUserMessages()
            }
        }.onAppear{
            fetchUserMessages()
        }
        
        
    }
    
    private func fetchUserMessages() {
        guard let toId = userChat?.id else { return }
        
        FirebaseManager.shared.fetchMessages(toId: String(toId)) { fetchedMessages, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching messages: \(error.localizedDescription)")
                } else {
                    // Sort messages by timestamp
                    self.messages = fetchedMessages.sorted(by: { $0.timestamp < $1.timestamp })
                }
            }
        }
    }
    
    
    
    
    struct DescriptionPlaceholder: View {
        var body: some View {
            HStack {
                Text("Description")
                    .foregroundColor(Color(.gray))
                    .font(.system(size: 17))
                    .padding(.leading, 5)
                    .padding(.top, -4)
                Spacer()
            }
        }
    }
}
