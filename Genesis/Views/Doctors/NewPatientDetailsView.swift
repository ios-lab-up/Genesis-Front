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
                            HStack{
                                ZStack{
                                    Image("skinSample")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 135, height: 135)
                                        .clipShape(Rectangle())
                                        .clipShape(RoundedRectangle(cornerRadius: 22))
                                    RoundedRectangle(cornerRadius: 22)
                                        .fill(.black)
                                        .frame(width: 135, height: 135)
                                        .opacity(0.4)
                                    
                                    Text("21 de noviembre,\n2023")
                                        .foregroundStyle(Color(.white))
                                        .font(.system(size: 12))
                                        .frame(maxWidth: .infinity ,maxHeight: 100, alignment: .bottomLeading)
                                        .padding(.leading)
                                }
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
