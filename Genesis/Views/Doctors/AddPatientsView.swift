//
//  AddPatientsView.swift
//  DermAware
//
//  Created by Luis Cedillo M on 25/11/23.
//

//
//  AddPatientView.swift
//  DermAware
//
//  Created by Mauricio Pérez on 25/11/23.
//

import SwiftUI

struct AddPatientsView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                ForEach((1...5).reversed(), id: \.self) {
                    ZStack{
                        HStack{
                            VStack{
                                HStack{
                                    Image("imagenPaciente")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 97, height: 97)
                                        .clipShape(Circle())
                                    VStack(alignment: .leading){
                                        Text("Sara Miranda")
                                            .font(.system(size: 32, weight: .semibold))
                                        Text("21 de noviembre, 2023") //Esta es la fecha de la última cita
                                            .font(.system(size: 12))
                                        Text("Melanoma")
                                            .font(.system(size: 16))
                                    }
                                    .foregroundStyle(Color(.white))
                                }
                                HStack{
                                    NavigationLink(destination: ScheduleView()){
                                        Text("Agendar Cita")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundStyle(Color("blackish"))
                                            .padding()
                                            .padding(.horizontal, 20)
                                            .background(Color("yellowsito"))
                                            .clipShape(Capsule())
                                    }
                                    NavigationLink(destination: NewPatientDetailsView()){
                                        Text("Detalles")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundStyle(Color(.white))
                                            .padding()
                                            .overlay(
                                                    RoundedRectangle(cornerRadius: 50)
                                                        .stroke(.white, lineWidth: 3)
                                                )
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        .background(Color("blackish"))
                        .cornerRadius(22)
                    }
                        Text("\($0)")
                        .font(.system(size: 6))
                        .hidden()
                }
            }
        }
            .navigationTitle("Pacientes")        
    }
}

#Preview {
    AddPatientsView()
}
