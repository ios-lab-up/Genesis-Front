//
//  HealthKitIntegration.swift
//  Genesis
//
//  Created by Luis Cedillo M on 09/11/23.
//

import HealthKit
import SwiftUI


class HealthManager: ObservableObject{
    let healthStore = HKHealthStore()
    
    @Published var userHealthData: [String:UserHealthData] = [:]
    
    init() {
        // Define the data types you want to read from HealthKit.
        let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let heightType = HKObjectType.quantityType(forIdentifier: .height)!
        let weightType = HKObjectType.quantityType(forIdentifier: .bodyMass)!
        let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType)!
        let genderType = HKObjectType.characteristicType(forIdentifier: .biologicalSex)!
        let dateOfBirthType = HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!
        let healthKitTypesToRead: Set<HKObjectType> = [stepCountType, heightType, weightType, bloodType, genderType, dateOfBirthType]
        // Combine the data types into a set.
       

        // Create an asynchronous task to request authorization.
        Task {
            do {
                // Request authorization for the data types.
                try await healthStore.requestAuthorization(toShare: [], read: healthKitTypesToRead)
            } catch {
                // If an error occurs, handle it here.
                print("Error requesting authorization: \(error)")
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
    
    func fetchBloodType() {
        guard HKHealthStore.isHealthDataAvailable(),
              let bloodTypeType = HKObjectType.characteristicType(forIdentifier: .bloodType) else {
            print("Blood Type data is not available")
            return
        }

        healthStore.requestAuthorization(toShare: nil, read: Set([bloodTypeType])) { [weak self] success, error in
            guard let self = self, success else {
                print("Authorization failed with error: \(String(describing: error))")
                return
            }

            do {
                let bloodTypeResult = try self.healthStore.bloodType()
                let bloodType = bloodTypeResult.bloodType
                let bloodTypeString = self.string(from: bloodType)
                let bloodData = UserHealthData(
                    id: 2,
                    title: "Blood Type",
                    subtitle: "",
                    image: "drop.fill",
                    amount: bloodTypeString
                )
                
                // Dispatch the update to the main thread
                DispatchQueue.main.async {
                    self.userHealthData["bloodType"] = bloodData
                }
            } catch {
                DispatchQueue.main.async {
                    print("Failed to fetch blood type: \(error.localizedDescription)")
                }
            }
        }
    }

    // Utility function to convert HKBloodType to a string representation
    private func string(from bloodType: HKBloodType) -> String {
        switch bloodType {
        case .notSet: return "Unknown"
        case .aPositive: return "A+"
        case .aNegative: return "A-"
        case .bPositive: return "B+"
        case .bNegative: return "B-"
        case .abPositive: return "AB+"
        case .abNegative: return "AB-"
        case .oPositive: return "O+"
        case .oNegative: return "O-"
        @unknown default: return "Unknown"
        }
    }

    func fetchHeight() {
        let heightType = HKSampleType.quantityType(forIdentifier: .height)!
        let query = HKSampleQuery(sampleType: heightType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]) { [weak self] query, results, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    // Handle any errors by informing the user or updating the UI.
                    print("An error occurred while fetching the height: \(error.localizedDescription)")
                }
                return
            }

            guard let heightSample = results?.first as? HKQuantitySample else {
                // No height samples available
                return
            }

            let height = heightSample.quantity.doubleValue(for: HKUnit.meter())
            let heightString = String(format: "%.2f meters", height) // Format height string to two decimal places

            // Create the UserHealthData instance for height
            let heightData = UserHealthData(
                id: 3, // Unique identifier for height data
                title: "Height",
                subtitle: "", // Subtitle if needed
                image: "arrow.up.and.down", // An example system image for height
                amount: heightString
            )
            
            // Update the  dictionary
            DispatchQueue.main.async {
                self.userHealthData["height"] = heightData
            }
        }
        healthStore.execute(query)
    }
    func fetchWeight() {
        let weightType = HKSampleType.quantityType(forIdentifier: .bodyMass)!
        
        // Sort descriptors to get the most recent data first
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        // Set the query to fetch only the most recent data
        let query = HKSampleQuery(sampleType: weightType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { [weak self] _, results, error in
            guard let self = self else { return }

            if let error = error {
                // Handle any errors here
                DispatchQueue.main.async {
                    print("An error occurred while fetching weight: \(error.localizedDescription)")
                }
                return
            }

            // Assuming you only want the latest weight entry
            if let weightSample = results?.first as? HKQuantitySample {
                let weight = weightSample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                let weightString = "\(Int(weight)) kg" // Converts the weight to a string with "kg" unit

                // Create the UserHealthData instance for weight
                let weightData = UserHealthData(
                    id: 4,
                    title: "Weight",
                    subtitle: "Most recent measurement",
                    image: "scalemass",
                    amount: weightString
                )
                
                // Update the userHealthData dictionary on the main thread
                DispatchQueue.main.async {
                    self.userHealthData["weight"] = weightData
                }
            } else {
                DispatchQueue.main.async {
                    print("No weight samples found.")
                }
            }
        }

        healthStore.execute(query)
    }



    func fetchGender() {
        do {
            let gender = try healthStore.biologicalSex().biologicalSex
            let genderString = self.string(from: gender)
            let genderData = UserHealthData(
                id: 5, // Unique identifier for gender data
                title: "Gender",
                subtitle: "", // Subtitle if needed
                image: "person.fill", // An example system image for gender
                amount: genderString
            )
            
            self.userHealthData["gender"] = genderData
        } catch {
            print("Failed to fetch gender: \(error.localizedDescription)")
        }
    }
    
    func fetchAge() {
        do {
            let birthdayComponents = try healthStore.dateOfBirthComponents()
            let today = Date()
            let thisYearBirthday = Calendar.current.date(from: DateComponents(year: today.getYear(), month: birthdayComponents.month, day: birthdayComponents.day))
            var age = today.getYear() - birthdayComponents.year! // Force-unwrapping is safe here if year is guaranteed
            
            // Check if this year's birthday has occurred yet; if not, subtract one year from age
            if let thisYearBirthday = thisYearBirthday, thisYearBirthday > today {
                age -= 1
            }
            
            let ageString = "\(age) years old"
            let ageData = UserHealthData(
                id: 6, // Unique identifier for age data
                title: "Age",
                subtitle: "", // Subtitle if needed
                image: "calendar", // An example system image for age
                amount: ageString
            )
            
            DispatchQueue.main.async {
                self.userHealthData["age"] = ageData
            }
        } catch {
            print("Failed to fetch age: \(error.localizedDescription)")
        }
    }


    
    // Utility function to convert HKBiologicalSex to a string representation
    private func string(from biologicalSex: HKBiologicalSex) -> String {
        switch biologicalSex {
        case .notSet: return "Unknown"
        case .female: return "Female"
        case .male: return "Male"
        case .other: return "Other"
        @unknown default: return "Unknown"
        }
    }


}

struct UserHealthData{
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let amount: String
}
