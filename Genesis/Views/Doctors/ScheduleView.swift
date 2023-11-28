//
//  ScheduleView.swift
//  DermAware
//
//  Created by Luis Cedillo M on 25/11/23.
//

//
//  ScheduleView.swift
//  DermAware
//
//  Created by Mauricio Pérez on 25/11/23.
//

import SwiftUI

struct ScheduleView: View {
    @State private var scheduleDate = Date.now
    @State var showDoctorDash = false
    @ObservedObject var globalDataModel = GlobalDataModel.shared
    var body: some View {
        VStack{
            DatePicker("Enter your birthday", selection: $scheduleDate)
                .datePickerStyle(GraphicalDatePickerStyle())
            
            VStack{
                Text("Tu cita se programaría para el ")
                HStack{
                    Text("\(scheduleDate, style: .date) ")
                        .bold()
                    Text("a las ")
                    Text("\(scheduleDate, style: .time)")
                        .bold()
                }
            }
                .font(.system(size: 18))
            Spacer()
            Button(action: {
                //showDoctorDash.toggle()
                globalDataModel.tabSelectionDr = "1"
            }){
                Text("Agendar cita")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color(.white))
                    .padding()
                    .padding(.horizontal, 25)
                    .background(Color("blackish"))
                    .clipShape(RoundedRectangle(cornerRadius: 22))
            }
            
            
            
            
            
            
            }
        .padding()
    
        
            .navigationTitle("Agendar cita")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showDoctorDash){
                DoctorDashboardView()
            }
    }
}

#Preview {
    ScheduleView()
}
