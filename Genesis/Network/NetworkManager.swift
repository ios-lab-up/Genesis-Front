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

struct ImageData: Codable {
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
            getUserData { result in
                switch result {
                case .success:
                    completion(true, nil)
                case .failure(let error):
                    // If there's an error (likely 401 Unauthorized), the token is invalid or expired.
                    completion(false, error)
                }
            }
        
        }
}





