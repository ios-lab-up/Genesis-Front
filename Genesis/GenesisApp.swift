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
        }
    }
}

/*fileprivate extension UINavigationBar {
    
    static func applyCustomAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}*/
