//
//  HomeView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI



struct HomeView: View {
    @ObservedObject var globalDataModel = GlobalDataModel.shared
    var body: some View {
        TabView(selection: $globalDataModel.tabSelection ){
            DashboardView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
                .tag("1")
                
            Photo()
                .tabItem {
                    Label("Analizar", systemImage: "camera")
                }
                .tag("2")
                .environmentObject(ViewModel())
            
            ScheduleView()
                .tabItem {
                    Label("Calendario", systemImage: "calendar")
                }
                .tag("3")
            
            /*HealthKitView()
                .tabItem {
                    Label("My Badge", systemImage: "heart.text.square.fill")
                }
                .environmentObject(HealthManager())*/
             }

        }
    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
