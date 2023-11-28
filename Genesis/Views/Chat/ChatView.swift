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
    
    private var currentUserId: String {
            String(globalData.user?.id ?? -1)
        }
    
    var body: some View {
        NavigationView {
                   VStack {
                       ScrollView(showsIndicators: false){
                           ForEach(messages) { message in
                               
                               if message.fromId == currentUserId {
                                   MessageView(message: message, isCurrentUser: true)
                               } else {
                                   MessageView(message: message, isCurrentUser: false)
                               }
                           }
                       }
                       .padding(.horizontal)
                       .background(Color(.init(white: 0.95, alpha: 1)))

                .background(Color("ListColor"))
                       HStack {
                           Image(systemName: "photo.on.rectangle")
                               .font(.system(size: 20)) // Tamaño ajustado del ícono
                               .foregroundColor(.gray)
                               .padding(.leading, 10) // Padding interno del icono

                           TextEditor(text: $chatText)
                               .frame(minHeight: 30, maxHeight: 30) // Limita la altura del TextEditor
                               .padding(4) // Padding interno para el texto
                               
                               

                           Button(action: {
                               // Acciones para enviar el mensaje
                           }) {
                               Image(systemName: "paperplane.fill")
                                   .foregroundColor(.white)
                                   .padding(8) // Padding interno del botón de enviar
                                   .background(Color.blue)
                                   .clipShape(Circle())
                           }
                           .padding(.trailing, 10) // Padding externo del botón de enviar
                       }
                       .padding(.horizontal, 10) // Padding externo del HStack
                       .padding(.vertical, 8) // Padding vertical para el HStack
                       .background(Color.white)
                       .cornerRadius(20) // Radio de las esquinas del fondo
                       .shadow(radius: 1) // Sombra opcional para profundidad



                .background(Color("ListColor"))
                .toolbar{
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

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter.string(from: date)
}
