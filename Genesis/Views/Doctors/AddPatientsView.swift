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
        NavigationView{
            ZStack{
                HStack{
                    VStack{
                        HStack{
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.gray)
                                .frame(width: 100, height: 100)
                                .padding(.trailing)
                            VStack(alignment: .leading){
                                Text("Ivan Cruz")
                                    .font(.system(size: 32, weight: .semibold))
                                Text("21 de noviembre, 2023")
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
                            NavigationLink(destination: ScheduleView()){
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
                .navigationTitle("Mis pacientes")
        }
    }
}

#Preview {
    AddPatientsView()
}
