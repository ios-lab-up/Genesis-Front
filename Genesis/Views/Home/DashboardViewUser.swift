import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserRelationsView()
        }
    }
}

class UserRelationsViewModel: ObservableObject {
    @Published var users: [User]?
    @Published var isLoading = false
    @Published var error: Error?

    func fetchUserRelations() {
        self.isLoading = true
        NetworkManager.shared.getUser2UserRelations { [weak self] (result: Result<[User], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users = users
                case .failure(let error):
                    self?.error = error
                }
                self?.isLoading = false
            }
        }
    }
}

struct UserRelationsView: View {
    @StateObject private var viewModel = UserRelationsViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                if viewModel.isLoading {
                    ProgressView()
                } else if let users = viewModel.users, !users.isEmpty {
                    ForEach(users, id: \.id) { user in
                        DashboardViewUser(user: user)
                    }
                } else {
                    Text("You still don't have a doctor")
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("Home", displayMode: .large)
        }
        .onAppear {
            viewModel.fetchUserRelations()
        }
    }
}

struct DashboardViewUser: View {
    var user: User

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 15) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 50))
                VStack(alignment: .leading, spacing: 5) {
                    Text(user.name) // assuming User has a 'name' property
                        .font(.title)
                    Text(user.username) // Displaying the username for the demo
                        .font(.headline)
                }
            }
            Text("Next Appointment: dd/MM/AAAA") // Placeholder text for the next appointment
                .font(.headline)
                .padding(.top, 10)
        }
        .padding(30)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color(hex: "B099DE"))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0

        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// For testing purposes
struct Preview {
    static var previews: some View {
        UserRelationsView()
    }
}
