import Combine

class AppFlowViewModel: ObservableObject {
    @Published var isAuthenticating: Bool = true
    @Published var isAuthenticated: Bool?  // true: autenticado, false: no autenticado, nil: indeterminado
}
