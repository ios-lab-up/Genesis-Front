import SwiftUI

struct ContentView: View {
    let networkManager = NetworkManager.shared
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        HomeView()
    }
}
