//
//  GenesisApp.swift
//  Genesis
//
//  Created by Luis Cedillo M on 23/07/23.
//

import CoreML
import SwiftUI

@main
struct GenesisApp: App {
    init() {
        // UINavigationBar.applyCustomAppearance()
    }
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
                .onAppear{
                    UserDefaults.standard.setValue(true, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}

