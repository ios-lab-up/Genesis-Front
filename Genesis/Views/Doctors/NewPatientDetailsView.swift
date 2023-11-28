//
//  NewPatientDetailsView.swift
//  DermAware
//
//  Created by Luis Cedillo M on 25/11/23.
//



import SwiftUI

struct NewPatientDetailsView: View {
    var body: some View {
            VStack{
                Image("imagenPaciente")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 170, height: 170)
                    .clipShape(Circle())
                Text("Sara Miranda")
                    .font(.system(size: 24, weight: .semibold))
                Text("sara.m@example.com")
                    .font(.system(size: 24))
                Spacer()
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach((1...5), id: \.self) {
                            NavigationLink(destination: PresDetailsView()){
                                ZStack{
                                    Image("skinSample")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(RoundedRectangle(cornerRadius: 22))
                                    RoundedRectangle(cornerRadius: 22)
                                        .fill(.black)
                                        .opacity(0.4)
                                    
                                    VStack(alignment: .leading) {
                                        Text("21 de noviembre,")
                                        Text("2023")
                                            
                                    }
                                    .foregroundStyle(Color(.white))
                                    .font(.system(size: 12))
                                    .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                                }
                                .frame(width: 135, height: 135)
                                .clipShape(RoundedRectangle(cornerRadius: 22))
                            }
                                Text("\($0)")
                                .font(.system(size: 1))
                                .hidden()
                            }
                    }
                }
                .padding()
                Spacer()
                
                
                
            }
            
            .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
        }
    
}

#Preview {
    NewPatientDetailsView()
}
