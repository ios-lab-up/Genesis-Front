//
//  DoctorInfoView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 22/11/23.
//

import SwiftUI

struct DoctorInfoView: View {
    var doctor: User
    @State private var isSelected: Bool = false
    @State var showchatView = false
    let currentDate = Date()
    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        formatter.locale = Locale(identifier: "en_US_POSIX") // Use a locale that ensures the month is in uppercase English
        return formatter
    }()
    
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(isSelected ? Color.blue : Color("blackish"))
            HStack{
                
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                    Text(doctor.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.top,15)
                        .padding(.leading, 15)
                    Text(doctor.email)
                        .font(.subheadline)
                        .foregroundColor(Color("primaryShadow"))
                        .padding(.leading, 15)
                    HStack
                    {
                        Button(action: {
                            showchatView.toggle()
                            
                        }) {
                            Text("Enviar Mensaje")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color("yellowsito"))
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color("yellowsito"), lineWidth: 1)
                                )
                        }
                        .padding(.bottom, 16)
                        .padding(.horizontal, 16)
                        Spacer()
                    }
                    .padding(.vertical)
                }
          
                VStack{
                    VStack {
                        if let nextAppointmentDateString = GlobalDataModel.shared.medicalHistory.last?.nextAppointmentDate,
                           let date = DateFormatter.yyyyMMdd.date(from: nextAppointmentDateString) {
                            VStack(spacing: 0) {
                                Text(dayFormatter.string(from: date)) // Day
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                Text(monthFormatter.string(from: date).uppercased()) // Month
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 70, height: 80)
                            .background(Color.black)
                            .cornerRadius(15)
                        } else {
                            // Placeholder if date is not available
                            Text("N/A")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 70, height: 80)
                                .background(Color.black)
                                .cornerRadius(15)
                        }
                    }
                    .frame(width: 70, height: 80)
                    .background(Color.black)
                    .cornerRadius(15)
                    Text("Prox. Cita")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 70, height: 20)
                        .background(Color.white)
                        .cornerRadius(15)
                }
                .padding()
               
            }
        }
        .frame(height: 150)
        .padding()
        .fullScreenCover(isPresented: $showchatView){
            ChatView()
        }
        
    }
}
