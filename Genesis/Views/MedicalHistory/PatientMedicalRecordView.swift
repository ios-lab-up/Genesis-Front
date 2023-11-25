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
    
    
    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd" // Use the format "dd MMM" for day and abbreviated month
        formatter.locale = Locale(identifier: "es_MX") // Adjust for your locale
        return formatter
    }()
    
    let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        formatter.locale = Locale(identifier: "en_US_POSIX") // Use a locale that ensures the month is in uppercase English
        return formatter
    }()
    

    
    
    var body: some View {
        NavigationView{
            List(globalDataModel.medicalHistory) { item in
             
                NavigationLink(destination: PrescriptionView(prescriptions: item.prescriptions, diagnostic: item.diagnostic)){
                    HStack(spacing: 10){
                        
                        ZStack{
                            Circle()
                                .foregroundStyle(Color("primaryShadow"))
                            
                            Image(systemName: "stethoscope")
                                .foregroundStyle(Color("Primary"))
                        }
                        .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading){
                            
                            Text(item.diagnostic)
                                .fontWeight(.bold)
                                .font(.title3)
                            
                            VStack(alignment: .leading){
                                Text("Observaciones:")
                                    .font(.caption)
                                    .bold()
                                    .foregroundStyle(Color.gray)
                                Text(item.observation)
                                    .font(.caption)
                                    .foregroundStyle(Color.gray)
                            }
                        }
                           Spacer()
                            
                        VStack(alignment: .trailing){
                                if let date = DateFormatter.yyyyMMdd.date(from: item.dateOfVisit) {
                                    VStack(spacing: 0) {
                                        Text(dayFormatter.string(from: date)) // Day
                                            .font(.system(size: 34, weight: .bold))
                                           
                                        Text(monthFormatter.string(from: date).uppercased()) // Month
                                            .font(.system(size: 12, weight: .semibold))
                                           
                                    }
                                    .frame(width: 70, height: 80)
                                } else {
                                    // Placeholder if date is not available
                                    Text("N/A")
                                        .font(.system(size: 24, weight: .bold))
                                 
                                        .frame(width: 70, height: 80)
                                        .background(Color.black)
                                        .cornerRadius(15)
                                }
                            }
                        
                       
                        
                     
                       
                        
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

