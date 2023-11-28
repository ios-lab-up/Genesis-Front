import CoreML
import SwiftUI
import Firebase

@main
struct GenesisApp: App {
    
    
    init() {
        FirebaseApp.configure()
    }
    
    let networkManager = NetworkManager.shared
    @ObservedObject var appFlowVM = AppFlowViewModel()
    @StateObject var healthManager = HealthManager()
    var viewModel = ViewModel() // Create an instance of ViewModel

    var body: some Scene {
        WindowGroup {
            AppContainerView(appFlowVM: appFlowVM, networkManager: networkManager)
                .environmentObject(GlobalDataModel.shared) // Provide GlobalDataModel
                .environmentObject(viewModel) // Provide ViewModel
        }
    }
}



struct AppContainerView: View {
    var healthManager = HealthManager()
    @ObservedObject var appFlowVM: AppFlowViewModel
    let networkManager: NetworkManager
    @EnvironmentObject var globalDataModel: GlobalDataModel
   
    var body: some View {
        Group {
            if appFlowVM.isAuthenticating {
                SplashScreenView()
                
            } else if appFlowVM.isAuthenticated == true {
                if globalDataModel.user?.profileId == 1
                {
                    HomeView()
                        .environmentObject(globalDataModel)
                        .environmentObject(healthManager)
                }
                else{
                    DoctorHomeView()
                        .environmentObject(globalDataModel)  .environmentObject(healthManager)
                }
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

