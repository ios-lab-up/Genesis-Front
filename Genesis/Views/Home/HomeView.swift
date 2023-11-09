//
//  HomeView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI



struct HomeView: View {
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                
            Photo()
                .tabItem {
                    Label("Analize", systemImage: "camera")
                }
                .environmentObject(ViewModel())
            
            HealthKitView()
                .tabItem {
                    Label("My Badge", systemImage: "heart.text.square.fill")
                }
                .environmentObject(HealthManager())
             }

        }
    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
