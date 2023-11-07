//
//  DashboardView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var globalDataModel: GlobalDataModel
    var body: some View {
        
        NavigationView {
            VStack{
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("primaryShadow"))
                    VStack(alignment: .leading){
                        Text("Welcome back")
                            .font(.title)
                        Text("\(globalDataModel.user?.name ?? "Guest")")
                            .font(.title)
                            .bold()
                            
                            
                        
                        Text("\(globalDataModel.user?.email ?? "Guest")")
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
                .padding(.bottom, 10)
                
                
                
                VStack(alignment: .leading){
                    Text("Your Doctor")
                        .font(.title)
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("primaryShadow"))
                        .frame(height: 150)
                    
                    
                    
                }
                
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Records")
                            .font(.title)
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("View all")
                        })
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0..<10) { index in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .fill(Color("primaryShadow"))
                                        .frame(width: 150, height: 180)
                                    VStack(alignment: .leading){
                                        HStack{
                                            Spacer()
                                            
                                            ZStack{
                                                Circle()
                                                    .frame(width: 60, height: 60)
                                                    .foregroundStyle(Color("circlePurple"))
                                                
                                                Text("\(index)")
                                                    .foregroundColor(.white)
                                                
                                                
                                            }
                                        }
                                        
                                        
                                        Text("Record \(index)")
                                            .bold()
                                            .padding(.top, 10)
                                        
                                        Text("2023-07-12")
                                            .font(.footnote)
                                    }
                                    .padding()
                                }
                            }
                        }
                        
                    }
                    
                }
                
                Spacer()

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
                    .padding(.top, 30)
                }
            }
        }
    }
}




struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().environmentObject(GlobalDataModel.shared)
    }
}


