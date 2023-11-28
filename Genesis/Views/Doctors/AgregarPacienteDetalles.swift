//
//  AgregarPacienteDetalles.swift
//  DermAware
//
//  Created by Mauricio Pérez on 27/11/23.
//

import SwiftUI

struct AgregarPacienteDetalles: View {
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
            ZStack{
                Image("skinSample")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                RoundedRectangle(cornerRadius: 22)
                    .fill(.black)
                    .frame(width: 186, height: 186)
                    .opacity(0.4)
                VStack{
                    Text("21 de noviembre,\n2023")
                        .font(.system(size: 16, weight: .semibold))
                        
                    Spacer()
                    
                    VStack{
                        Text("Melanoma")
                            .font(.system(size: 16, weight: .semibold))
                        Text("69%")
                            .font(.system(size: 36, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    
                }
                .foregroundStyle(Color(.white))
                .padding()
                
            }
            .frame(width: 186, height: 186)
            .clipShape(RoundedRectangle(cornerRadius: 22))
            Spacer()
            
            NavigationLink(destination: DoctorDashboardView()){
                Text("Agregar")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color(.white))
                    .padding()
                    .padding(.horizontal, 25)
                    .background(Color("blackish"))
                    .clipShape(RoundedRectangle(cornerRadius: 22))
            }
        }
        
        .navigationTitle("Detalles")
    .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AgregarPacienteDetalles()
}
