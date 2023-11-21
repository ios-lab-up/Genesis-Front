//
//  Dashboard.swift
//  Genesis
//
//  Created by Sara Miranda on 20/11/23.
//

import SwiftUI

struct Dashboard: View {
    let name: String
    let msj_doctor: String
    let dr: String
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    VStack{
                        Text("Hola, " + name + "!")
                        Text("Cómo te sientes hoy?")
                    }
                    Spacer()
                    Text("Perfil")
                    Spacer()
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(Color("yellowsito"))
                    VStack
                    {
                        Text("Aqui va la hora")
                        Text(msj_doctor)
                        
                    }
                    
                }
                
                Text("Que te gustaría hacer?")
                HStack{
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundStyle(Color("purplit"))
                        VStack
                        {
                            Text("Aqui va el Diagnostico")
                            Text("Conoce tu diagnóstico")
                            Text("Conoce tu diagnostico a detalle")
                        }
                        
                    }
                    VStack{
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 25.0)
                                .foregroundStyle(Color("bluey"))
                            VStack {
                                Text("Lista de medicamentos")
                                Text("Lista de medicamentos")
                            }
                            
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .foregroundStyle(Color("primaryShadow"))
                            Text("lorem algo")
                        }
                    }
                    
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(Color("blackish"))
                    HStack {
                        Spacer()
                        VStack {
                            Text("Dr" + dr)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                            Text("Especialidad")
                                .foregroundColor(Color("primaryShadow"))
                            
                        }
                        Spacer()
                        VStack {
                            Text("Fecha")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Text("prox.cita")
                        }
                        Spacer()
                    }
                }
                

            }.frame(width: 350)
        }
        
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(name: "Wichi mi vida", msj_doctor: "Toma paracetamol porfis", dr: "doc" )
    }
}
