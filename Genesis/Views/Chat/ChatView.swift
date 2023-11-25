import SwiftUI

// Define the ChatMessage model if not already defined


// ChatView to display and send messages
struct ChatView: View {
    
    @Environment(\.presentationMode) var close
    let userChat = GlobalDataModel.shared.userRelations.first?.name ?? "Your Doctor"
    

    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    ForEach(0..<10){_ in
                        Text("Message View")
                    }
                }.navigationTitle(userChat)
                    .navigationBarTitleDisplayMode(.inline)
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
        }
    }

    
}




