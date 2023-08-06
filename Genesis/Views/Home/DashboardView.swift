//
//  DashboardView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            VStack{
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("primaryShadow"))
                    VStack(alignment: .leading){
                        Text("Your skin \nrecaps")
                            .font(.title)
                            
                        
                        Text("Lorem ipsum dolor sit amet")
                            .font(.footnote)
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Get started")
                                .font(.footnote)
                                .foregroundStyle(.black)
                                .padding(5)
                        })
                        
                    }
                    .padding()
                }
                
                .frame(height: 200)
            }
            .padding()
            
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Insights")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                            .bold()
                        
                        Spacer()
                        
                        AsyncImage(url: URL(string: "https://media.discordapp.net/attachments/856712471774494720/1134959498113589399/Memoji_Disc.png?width=809&height=809")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                        } placeholder: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.purple)
                            }
                        }
                        .frame(width: 60, height: 60) // Ajusta el tamaño según tus necesidades
                    }
                    .padding(.top, 60)
                }
            }
        }
    }
}




struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}


