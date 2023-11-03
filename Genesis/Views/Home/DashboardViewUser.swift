//
//  DashboardViewUser.swift
//  Genesis
//
//  Created by Luis Cedillo M on 03/11/23.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 25) {
                    
                    DashboardViewUser()
                    DashboardViewUser()
                    DashboardViewUser()
                    DashboardViewUser()
                    Spacer()

                }
                .padding()
                .navigationBarTitle("Home", displayMode: .large)
            }
        }
    }
}





struct DashboardViewUser: View {
    var body: some View {
        VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 15) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 50))
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Doctor Name")
                                .font(.title)
                            Text("Especialty")
                                .font(.headline)
                        }
                    }
                    Text("Next Appointment")
                        .font(.headline)
                        .padding(.top, 10)
                }
                .padding(30)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color(hex: "E1F0F5"))
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


#Preview {
    DashboardViewUser()
}
