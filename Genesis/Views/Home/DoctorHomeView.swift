//
//  DoctorHomeView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 22/11/23.
//

import SwiftUI

struct DoctorHomeView: View {
    var body: some View {
           TabView {
               DoctorDashboardView()
                   .tabItem {
                       Label("Home", systemImage: "house")
                   }
                   
               AddPatientsView()
                   .tabItem {
                       Label("Patients", systemImage: "person.3.fill")
                   }
               
               ChatView()
                   .tabItem {
                       Label("Chat", systemImage: "message.fill")
                   }
                }

           }
       }

#Preview {
    DoctorHomeView()
}
