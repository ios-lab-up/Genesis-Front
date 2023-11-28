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
                   
               Photo()
                   .tabItem {
                       Label("Calendar", systemImage: "calendar")
                   }
                   .environmentObject(ViewModel())
               
              /* HealthKitView()
                   .tabItem {
                       Label("My Badge", systemImage: "heart.text.square.fill")
                   }
                   .environmentObject(HealthManager())*/
                }

           }
       }

#Preview {
    DoctorHomeView()
}
