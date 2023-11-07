import CoreML
import SwiftUI

@main
struct GenesisApp: App {
    let networkManager = NetworkManager.shared
    @ObservedObject var appFlowVM = AppFlowViewModel()

    var body: some Scene {
        WindowGroup {
            AppContainerView(appFlowVM: appFlowVM, networkManager: networkManager)
                .environmentObject(GlobalDataModel.shared) // Provide the shared instance here
        }
    }
}


struct AppContainerView: View {
    @ObservedObject var appFlowVM: AppFlowViewModel
    let networkManager: NetworkManager
    @EnvironmentObject var globalDataModel: GlobalDataModel // Access the global data model

    var body: some View {
        Group {
            if appFlowVM.isAuthenticating {
                SplashScreenView()
            } else if appFlowVM.isAuthenticated == true {
                HomeView()
                    .environmentObject(globalDataModel) // Pass the global data model to HomeView
            } else {
                signIn()
            }
        }
        .onAppear {
            networkManager.validateJwtToken { isValid, error in
                if isValid {
                    appFlowVM.isAuthenticated = true
                    // Optionally, fetch user data here if needed
                } else {
                    print("Token validation failed: \(error?.localizedDescription ?? "Unknown error")")
                    appFlowVM.isAuthenticated = false
                }
                appFlowVM.isAuthenticating = false
            }
        }
    }
}

