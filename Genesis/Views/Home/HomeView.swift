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
            EmptyView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            EmptyView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
