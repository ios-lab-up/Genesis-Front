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
        VStack {
            ProgressView()  // Indicador de carga predeterminado de SwiftUI
            Text("Cargando...")
        }
    }
}

#Preview {
    SplashScreenView()
}
