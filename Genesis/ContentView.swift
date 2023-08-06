import SwiftUI

struct ImageClassificationViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController

    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // update your view controller here
    }
}

/*struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                NavigationLink(destination: ImageClassificationViewControllerRepresentable()) {
                    Text("Image Classification")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                NavigationLink(destination: LoginView()) {
                                    Text("Login")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
            }
        }
    }
}*/

struct ContentView: View {
    var body: some View {
        signIn()
    }
}
