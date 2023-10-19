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
    // Define an instance of NetworkManager here to use its functions.
    let networkManager = NetworkManager.shared

    init() {
        // UINavigationBar.applyCustomAppearance()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
                .onAppear {
                    UserDefaults.standard.setValue(true, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                    
                    // Validate the JWT token when the app appears.
                    networkManager.validateJwtToken { isValid, error in
                        if isValid {
                            // If the token is valid, we update the state to reflect that the user is authenticated.
                            networkManager.isAuthenticated = true
                        } else {
                            // Handle the error or set isAuthenticated to false to show the SignInView.
                            print("Token validation failed: \(error?.localizedDescription ?? "Unknown error")")
                            networkManager.isAuthenticated = false
                        }
                    }
                }
        }
    }
}

