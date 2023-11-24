//
//  MainMessageView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 24/11/23.
//

import SwiftUI

struct MainMessageView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(0..<10, id: \.self) { num in
                    HStack{
                        Text("User Profile Image")
                        VStack{
                            Text("User Name")
                            Text("Message set to user")
                        }
                        Spacer()
                        
                        Text("22d")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    Divider()
             
                }
            }
            .navigationTitle("Chat")
        }
       
    }
}

#Preview {
    MainMessageView()
}
