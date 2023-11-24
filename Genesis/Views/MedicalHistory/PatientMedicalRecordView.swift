//
//  PatientMedicalRecordView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 22/11/23.
//

import SwiftUI

struct PatientMedicalRecordView: View {
    @Environment(\.presentationMode) var close
    @ObservedObject var globalDataModel = GlobalDataModel.shared
    var body: some View {
        NavigationView{
            List(globalDataModel.medicalHistory) { item in
             
                VStack(alignment: .leading, spacing: 15) {
                    Text(item.diagnostic)
                        .fontWeight(.bold)
                        .font(.title3)
                    HStack{
                        Text("Día de la visita:")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(Color.gray)
                        Text(item.dateOfVisit)
                            .font(.caption)
                            .foregroundStyle(Color.gray)
                    }
                    HStack{
                        Text("Observaciones:")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(Color.gray)
                        Text(item.observation)
                            .font(.caption)
                            .foregroundStyle(Color.gray)
                    }
                    
                 
                   
                    
                }
          
                .navigationTitle("Registro Médico")
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button(action:{
                            close.wrappedValue.dismiss()
                        }){
                            HStack{
                                Image(systemName: "chevron.left")
                                    .font(.caption)
                                
                            }
                            
                            
                        }
                    }
                }
            }
           
        }
    }
}

