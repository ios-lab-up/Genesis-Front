import CoreML
import SwiftUI

@main
struct GenesisApp: App {
    let networkManager = NetworkManager.shared
    @ObservedObject var appFlowVM = AppFlowViewModel()

    var body: some Scene {
        WindowGroup {
            AppContainerView(appFlowVM: appFlowVM, networkManager: networkManager)


        }
    }
}

struct AppContainerView: View {
    @ObservedObject var appFlowVM: AppFlowViewModel
    let networkManager: NetworkManager

    var body: some View {
        Group {
            if appFlowVM.isAuthenticating {
                SplashScreenView() 
            } else if appFlowVM.isAuthenticated == true {
                HomeView()
            } else {
                signIn()
            }
        }
        .onAppear {
            networkManager.validateJwtToken { isValid, error in
                if isValid {
                    appFlowVM.isAuthenticated = true
                } else {
                    print("Token validation failed: \(error?.localizedDescription ?? "Unknown error")")
                    appFlowVM.isAuthenticated = false
                }
                appFlowVM.isAuthenticating = false
            }
        }
    }
}
