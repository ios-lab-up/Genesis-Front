//
//  NetworkManager.swift
//  Genesis
//
//  Created by Luis Cedillo M on 24/07/23.
//

import Foundation
import Alamofire
import KeychainSwift




struct Response<T: Codable>: Codable {
    let data: T
    let message: String
    let status: Int
    let success: Bool
    // Consider adding an error or additional message field for server errors.
}

struct APIResponse<T: Decodable>: Decodable {
    let success: Bool
    let status: Int?
    let message: String?
    let error: String?
    let data: T? // This remains generic and can be 'Bool', 'User', or any other Decodable type
}

// ErrorResponse is used to represent error messages from the server.
struct ErrorResponse: Decodable {
    let error: String?
    let message: String
    let status: Int
    let success: Bool
}


struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let birthDate: String
    let cedula: String?
    let creationDate: String
    let jwtToken: String?  // Renamed for clarity and consistency.
    let lastUpdate: String
    // Removed `passwordHash` if it's not used client-side.
    let profileId: Int
    let isActive: Bool  // Renamed to reflect its meaning more clearly, assuming it means whether the user's account is active.

    enum CodingKeys: String, CodingKey {
        case id, name, username, email, cedula, isActive = "status"
        case birthDate = "birth_date"
        case creationDate = "creation_date"
        case jwtToken = "jwt_token"
        case lastUpdate = "last_update"
        case profileId = "profile_id"
    }
}

struct RootResponse: Codable {
    let data: ImagesDataWrapper
    let message: String
    let status: Int
    let success: Bool
}

// Wrapper structure for the 'data' dictionary in JSON that contains 'images'.
struct ImagesDataWrapper: Codable {
    let images: [ImageData]
}

struct Diagnostic: Codable, Equatable {
    let creationDate: String
    let description: String
    let id: Int
    let lastUpdate: String
    let precision: Double
    let sickness: String
    let status: Bool

    enum CodingKeys: String, CodingKey {
        case creationDate = "creation_date"
        case description
        case id
        case lastUpdate = "last_update"
        case precision
        case sickness
        case status
    }
}

// MARK: - Image Data
struct ImageData: Codable, Equatable, Identifiable {
    let creationDate: String
    let id: Int
    let image: String
    let lastUpdate: String
    let mlDiagnostic: [Diagnostic]
    let name: String
    let path: String
    let status: Bool

    enum CodingKeys: String, CodingKey {
        case creationDate = "creation_date"
        case id
        case image
        case lastUpdate = "last_update"
        case mlDiagnostic = "ml_diagnostic"
        case name
        case path
        case status
    }
    static func == (lhs: ImageData, rhs: ImageData) -> Bool {
            return lhs.id == rhs.id // Or any other logic you define for equality
        }
}

struct UserImage: Codable {
    let creationDate: String
    let id: Int
    let imageId: Int
    let lastUpdate: String
    let status: Bool
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case creationDate = "creation_date"
        case id
        case imageId = "image_id"
        case lastUpdate = "last_update"
        case status
        case userId = "user_id"
    }
}

// Assuming Prescription and UserImage structs are already defined
// as per your previous JSON structure

struct MedicalHistoryItem: Identifiable, Codable {
    var uuid = UUID()
    let associationId: Int
    let creationDate: String
    let dateOfVisit: String
    let diagnostic: String
    let followUpRequired: Bool
    let id: Int
    let lastUpdate: String
    let nextAppointmentDate: String
    let observation: String
    let patientFeedback: String
    let prescriptions: [Prescription]
    let privateNotes: String
    let status: Bool
    let symptoms: String
    let userImages: [UserImage]

    enum CodingKeys: String, CodingKey {
        case associationId = "association_id"
        case creationDate = "creation_date"
        case dateOfVisit = "date_of_visit"
        case diagnostic
        case followUpRequired = "follow_up_required"
        case id
        case lastUpdate = "last_update"
        case nextAppointmentDate = "next_appointment_date"
        case observation
        case patientFeedback = "patient_feedback"
        case prescriptions
        case privateNotes = "private_notes"
        case status
        case symptoms
        case userImages = "user_images"
    }
}

struct Prescription: Codable {
    let creationDate: String
    let dosage: String
    let endDate: String
    let frequencyUnit: String
    let frequencyValue: Int
    let id: Int
    let indications: String
    let lastUpdate: String
    let notificationsEnabled: Bool
    let startDate: String
    let status: Bool
    let treatment: String

    enum CodingKeys: String, CodingKey {
        case creationDate = "creation_date"
        case dosage
        case endDate = "end_date"
        case frequencyUnit = "frequency_unit"
        case frequencyValue = "frequency_value"
        case id
        case indications
        case lastUpdate = "last_update"
        case notificationsEnabled = "notifications_enabled"
        case startDate = "start_date"
        case status
        case treatment
    }
}



/// `APIEndpoints` provides full URL strings for network requests to the various endpoints of the Genesis API.
/// This struct constructs URLs by appending specific path components to the base URL.
struct APIEndpoints {
    /// The base URL for the Luis Home Server API.
    static let baseURL = "https://api.luishomeserver.com"

    /// URL for the 'sign up' endpoint.
    /// This endpoint is used for registering new users.
    static var signUp: String { baseURL + "/sign_up" }
    
    /// URL for the 'verify identity' endpoint within the 'sign up' process.
    /// This endpoint is used for verifying the identity of users during registration, likely with some form of token or code.
    static var verifyIdentity: String { baseURL + "/sign_up/verify_identity" }
    
    /// URL for the 'resend verification code' endpoint.
    /// This endpoint is used to resend a new verification code to users if needed during the sign-up process.
    static var resendVerificationCode: String { baseURL + "/sign_up/resend_verification_code" }
    
    /// URL for the 'sign in' endpoint.
    /// This endpoint is used for user login, likely requiring a username and password.
    static var signIn: String { baseURL + "/sign_in" }
    
    /// URL for the 'upload image' endpoint.
    /// This endpoint is used for uploading images, likely requiring the image data and possibly some form of user authentication.
    static var uploadImage: String { baseURL + "/upload_image" }
    
    /// URL for the 'get user images data' endpoint.
    /// This endpoint is used to retrieve the images data for the user, likely requiring some form of user authentication.
    static var getImages: String { baseURL + "/get_user_images_data" }
    
    static var getUserData: String { baseURL + "/get_user_data"}
    
    static var getUser2UserRelations: String { baseURL + "/get_user_to_user_relation"}
    
    static var getUserImages: String { baseURL + "/get_user_images_data"}
    
    static var signOut: String { baseURL + "/sign_out"}
    
    static var getMyMedicalHistory: String { baseURL + "/medical_history/get_my_medical_history"}
}

/// `NetworkManager` handles all network calls to the Genesis API.
/// It includes functions for signing up, verifying identity, resending verification codes, logging in, getting user data, and uploading images.
class NetworkManager:ObservableObject {
    
    // MARK: - Properties
    
    /// Shared instance for the network manager, used for singleton setup.
    static let shared = NetworkManager()
    
    /// A six-digit code which might be used for certain authentication processes.
    var sixDigitCode: String?
    
    /// The JWT token used for authenticated requests.
    var jwtToken: String?
    
    /// A flag indicating whether the user is authenticated.
    @Published var isAuthenticated: Bool?
    
    private let keychain = KeychainSwift()

    
    
    // Private initializer for singleton.
    private init() {}
    
    // MARK: - Network Operations
    
        
    // Add your methods like `signUp`, `verifyIdentity`, `resendVerificationCode`, `login`, `getUserData`, and `uploadImage` here,
    // replacing string concatenations for URLs with references to your `APIEndpoints` properties.
    // Example:
    // URL(string: APIEndpoints.baseURL + "/sign_up") becomes URL(string: APIEndpoints.signUp)

    // ...
}

extension NetworkManager {
    // Save the JWT token to the Keychain
    func saveToken(_ token: String) {
        keychain.set(token, forKey: "com.Genesis.jwtToken")
    }

    // Retrieve the JWT token from the Keychain
    func retrieveToken() -> String? {
        return keychain.get("com.Genesis.jwtToken")
    }

    // Delete the JWT token from the Keychain (useful for sign out)
    func deleteToken() {
        keychain.delete("com.Genesis.jwtToken")
    }
    
    func validateJwtToken(completion: @escaping (Bool, Error?) -> Void) {
        NetworkManager.shared.fetchAllUserData { getUserResult in
            switch getUserResult {
            case .success(let fetchedUser):
                print("Fetched user data: \(fetchedUser)")
                completion(true, nil)
            case .failure(let fetchError):
                print("Failed to fetch user data: \(fetchError)")
                completion(false, fetchError)
            }
        }
        
        }
    
    
}





