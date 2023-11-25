//
//  PrescriptionView.swift
//  DermAware
//
//  Created by Iñaki Sigüenza on 24/11/23.
//

import SwiftUI

struct PrescriptionView: View {
    var prescriptions: [Prescription]
    @State var diagnostic: String
    var body: some View {
        ZStack{
            Color("ListColor")
                .ignoresSafeArea(.all)
            
            
            VStack(alignment: .leading){
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.white)
                    
                    HStack{
                        ZStack{
                            Circle()
                                .foregroundStyle(Color("WarningBg"))
                            
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundStyle(Color("Warning"))
                        }
                        .frame(width: 50, height: 50)
                        .padding()
                        
                        VStack(alignment: .leading,spacing: 15){
                            Text("Recuerda lo siguiente")
                                .bold()
                            Text("Todos los medicamentos son recetados por tu médico, nunca debes automedicarte.")
                                .font(.subheadline)
                                .fontWeight(.light)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    
                }
                .frame(height: 150)
                .padding()
                
                Text("Prescripción médica")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(Color.black)
                    .padding(.leading)
                    .textCase(nil)
                List(prescriptions, id: \.id) { prescription in
                   
                        VStack(alignment: .leading, spacing: 5) {
                            Text(prescription.treatment)
                            
                            Text(prescription.dosage)
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
                            
                            Text(prescription.indications)
                                .font(.subheadline)
                                .bold()
                        }
                        .padding(20)
                    
                }
                .scrollContentBackground(.hidden)
            }
        }
        
        .navigationTitle(diagnostic)
    }
}


