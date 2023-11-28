//
//  UserBadgeView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 09/11/23.
//
import HealthKit
import SwiftUI



/*
struct HealthKitViewCard: View {
    var userHealthData: UserHealthData // Removed the @State as it should be a simple passed-in value

    var body: some View {
        ZStack {
            Color("primaryShadow")
                .cornerRadius(15)
                .shadow(radius: 5)
            
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(userHealthData.title) // Use dynamic title
                            .font(.system(size: 16))
                        
                        Text(userHealthData.subtitle) // Use dynamic subtitle
                            .font(.system(size: 12))
                    }
                    Spacer()
                    
                    Image(systemName: userHealthData.image)
                        .foregroundColor(.red)
                }
                
                Text(userHealthData.amount) // Use dynamic amount
                    .font(.system(size: 24))
            }
            .padding()
        }
    }
}



struct HealthKitView: View {
    @EnvironmentObject var healthManager: HealthManager
    
    var body: some View {
        VStack {
            Text("Your Medical Badge")
                .font(.system(size: 32, weight: .bold))
                .padding(.bottom, 20)
            // Rounded rectangle with a title
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("primaryShadow")) // You can choose the appropriate fill color
                .frame(height: 50)
                .overlay(
                    Text("Your Diagnosis:")
                        .foregroundColor(.black) // Choose the text color that fits your design
                        .font(.headline)
                )
                .padding(.horizontal)
                .padding(.top, 20) // Add some top padding if needed
            
            
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                // Iterate over the sorted health data and add padding to the top of each card.
                ForEach(healthManager.userHealthData.sorted(by: { $0.value.id < $1.value.id }), id: \.key) { key, value in
                    HealthKitViewCard(userHealthData: value)
                        .padding(.top) // Adds padding on the top of each card
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            healthManager.fetchTodaySteps()
            healthManager.fetchBloodType()
            healthManager.fetchHeight()
            healthManager.fetchGender()
            healthManager.fetchAge()
            healthManager.fetchWeight()

        }
    }
}

*/

extension Double{
    func formattedString() -> String?{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self))
    }
}



// Extension to get the current year as an integer from Date
extension Date {
    func getYear() -> Int {
        return Calendar.current.component(.year, from: self)
    }
}



