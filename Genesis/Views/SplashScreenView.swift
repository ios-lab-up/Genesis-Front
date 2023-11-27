//
//  SplashScreenView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 19/10/23.
//

import SwiftUI

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("Primary"), Color("Primary")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                    )
                .ignoresSafeArea(.all)
            
            Image("logo-spash")
                .resizable()
                .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    SplashScreenView()
}
