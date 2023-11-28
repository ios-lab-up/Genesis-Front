//
//  DoctorHomeView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 22/11/23.
//

import SwiftUI

struct DoctorHomeView: View {
    @ObservedObject var globalDataModel = GlobalDataModel.shared
    var body: some View {
        TabView(selection: $globalDataModel.tabSelectionDr){
               DoctorDashboardView()
                   .tabItem {
                       Label("Home", systemImage: "house")
                   }
                   .tag("1")
                   
               AddPatientsView()
                   .tabItem {
                       Label("Patients", systemImage: "person.3.fill")
                   }
                   .tag("2")
               
               ChatView()
                   .tabItem {
                       Label("Chat", systemImage: "message.fill")
                   }
                   .tag("3")
                }

           }
       }

#Preview {
    DoctorHomeView()
}
