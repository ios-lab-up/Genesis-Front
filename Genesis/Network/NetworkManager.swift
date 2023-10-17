//
//  NetworkManager.swift
//  Genesis
//
//  Created by Luis Cedillo M on 24/07/23.
//

import Foundation
import UIKit
import Alamofire


// Create a struct to hold all the API endpoints
struct APIEndpoints {
    static let baseURL = "https://api.luishomeserver.com"
    static let signUp = "/sign_up"
    static let verifyIdentity = "/sign_up/verify_identity"
    static let resendVerificationCode = "/sign_up/resend_verification_code"
    static let signIn = "/sign_in"
    static let uploadImage = "/upload_image"
    static func visualizeDoctorPatientFile(userId: Int, imageId: Int) -> String {
            return "/visualize_doctor_patient/\(userId)/\(imageId)"
        }
}

class NetworkManager {
    static let shared = NetworkManager()
    var sixDigitCode: String?
    var jwtToken: String?
    var isAuthenticated: Bool?
    private init() {}

    func signUp(name: String, username: String, email: String, password: String, birthDate: String, profileId: Int, cedula: String? = nil, completion: @escaping (Result<User, Error>) -> Void) {
 
        guard let url = URL(string: APIEndpoints.baseURL + APIEndpoints.signUp) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        var body: [String: Any] = ["name": name, "username": username, "email": email, "password": password, "birth_date": birthDate, "profile_id": profileId]
            if let cedulaValue = cedula {
                body["cedula"] = cedulaValue
            }
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response<User>.self, from: data)
                    self.jwtToken = response.data.jwtToken
                    completion(.success(response.data))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    func verifyIdentity(code: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.baseURL + APIEndpoints.verifyIdentity) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.jwtToken ?? "", forHTTPHeaderField: "x-access-token" )

        let body: [String: Any] = ["code": code]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response<User>.self, from: data)
                    self.isAuthenticated = response.success
                    completion(.success(response.data))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    func resendVerificationCode(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.baseURL + APIEndpoints.resendVerificationCode) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(self.jwtToken ?? "", forHTTPHeaderField: "x-access-token" )

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
        task.resume()
    }

    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let url = URL(string: APIEndpoints.baseURL + APIEndpoints.signIn)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = [
            "username": username,
            "password": password
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Failed to serialize data: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Failed to complete request: \(error)")
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    if let response = try? JSONDecoder().decode(Response<User>.self, from: data) {
                        self.jwtToken = response.data.jwtToken
                        completion(.success(response.data))
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to decode response"])
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
    
    func getUserData(completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.baseURL + "/get_user_data") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.jwtToken ?? "", forHTTPHeaderField: "x-access-token")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode(Response<User>.self, from: data) {
                        completion(.success(response.data))
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to decode response"])
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }

    
    func uploadImage(imageData: Data, diagnostic: String, completion: @escaping (Result<Response<ImageData>, Error>) -> Void) {
        // Check if jwtToken is not nil, otherwise return an error
        guard let token = self.jwtToken else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "JWT token is missing"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "Content-type": "multipart/form-data"
        ]
        
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpg") // image data
            multipartFormData.append(diagnostic.data(using: .utf8)!, withName: "diagnostic") // diagnostic data
        }, to: APIEndpoints.baseURL + APIEndpoints.uploadImage, method: .post, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                // Here, 'data' is the raw Data returned from the server
                if let string = String(data: data, encoding: .utf8) {
                    print("Received response:\n \(string)")
                }

                // Now, we'll decode the data and pass along the result
                do {
                    let decoded = try JSONDecoder().decode(Response<ImageData>.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }

    

    
}


   
    
    struct User: Codable {
        let id: Int
        let name: String
        let username: String
        let email: String
        let birthDate: String
        let cedula: String?
        let creationDate: String
        let jwtToken: String?
        let lastUpdate: String
        let passwordHash: String
        let profileId: Int
        let status: Bool
        
        enum CodingKeys: String, CodingKey {
            case id, name, username, email
            case birthDate = "birth_date"
            case cedula = "cedula"
            case creationDate = "creation_date"
            case jwtToken = "jwt_token"
            case lastUpdate = "last_update"
            case passwordHash = "password_hash"
            case profileId = "profile_id"
            case status
        }
    }
    
    
    


struct Response<T: Codable>: Codable {
    let data: T
    let message: String
    let status: Int
    let success: Bool
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

