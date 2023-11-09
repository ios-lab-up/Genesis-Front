//
//  UserBadgeView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 09/11/23.
//
import HealthKit
import SwiftUI


class HealthManager: ObservableObject{
    let healthStore = HKHealthStore()
    
    @Published var userHealthData: [String:UserHealthData] = [:]
    
    init(){
        let steps = HKObjectType.quantityType(forIdentifier: .stepCount)!
        
        let healthKitTypes: Set = [steps]
        
        Task {
            do{
                try await healthStore.requestAuthorization(toShare: [], read: healthKitTypes)
            }
            catch{
                print("error requesting authorization")
            }
        }
    }
    func fetchTodaySteps() {
        let stepsQuantityType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let predicate = HKQuery.predicateForSamples(withStart: Date.startOfToday, end: Date(), options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("something went wrong or no data was returned")
                return
            }
            let stepValue = quantity.doubleValue(for: HKUnit.count())
            let stepsFormattedString = stepValue.formattedString() ?? "N/A" // Provide "N/A" if nil
            
            let activity = UserHealthData(
                id: 1,
                title: "Daily Steps",
                subtitle: "Goal: 10,000",
                image: "heart.fill",
                amount: stepsFormattedString // Unwrapped string
            )
            
            DispatchQueue.main.async {
                self.userHealthData["steps"] = activity
            }
        }
        healthStore.execute(query)
    }


}

struct UserHealthData{
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let amount: String
}




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
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                // Convert dictionary to array and iterate
                ForEach(healthManager.userHealthData.sorted(by: { $0.value.id < $1.value.id }), id: \.key) { key, value in
                    HealthKitViewCard(userHealthData: value)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            healthManager.fetchTodaySteps()
        }
    }
}


extension Double{
    func formattedString() -> String?{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self))
    }
}





#Preview {
    HealthKitView()
        .environmentObject(HealthManager())
    
  
}
