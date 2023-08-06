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
                    Label("", systemImage: "house")
                }
                
            CameraView()
                .tabItem {
                    Label("", systemImage: "camera")
                }
            
            CameraView()
                .tabItem {
                    Label("", systemImage: "heart.text.square.fill")
                }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
