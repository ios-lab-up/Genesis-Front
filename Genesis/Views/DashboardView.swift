//
//  DashboardView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 03/08/23.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            //ImageClassificationView()
                .tabItem {
                    Image(systemName: "photo")
                    Text("Image Classifier")
                }

            //SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
