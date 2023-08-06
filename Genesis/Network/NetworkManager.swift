//
//  NetworkManager.swift
//  Genesis
//
//  Created by Luis Cedillo M on 24/07/23.
//

import Foundation
import UIKit

// Create a struct to hold all the API endpoints
struct APIEndpoints {
    static let baseURL = "https://f909-189-147-103-182.ngrok-free.app"
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

    
    
    
}

extension NetworkManager {
    func uploadImage(parameters: [[String: Any]], completion: @escaping (Result<ImageUploadResponse, Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.baseURL + APIEndpoints.uploadImage) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        
        for param in parameters {
            guard param["disabled"] == nil else { continue }
            if let paramName = param["key"] as? String,
               let paramType = param["type"] as? String {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition:form-data; name=\"\(paramName)\"".data(using: .utf8)!)
                if paramType == "text",
                   let paramValue = param["value"] as? String {
                    body.append("\r\n\r\n\(paramValue)\r\n".data(using: .utf8)!)
                } else if paramType == "file",
                          let paramSrc = param["src"] as? String,
                          let fileData = try? Data(contentsOf: URL(fileURLWithPath: paramSrc)) {
                    body.append("; filename=\"\(paramSrc)\"\r\nContent-Type: \"content-type header\"\r\n\r\n".data(using: .utf8)!)
                    body.append(fileData)
                    body.append("\r\n".data(using: .utf8)!)
                }
            }
        }
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue(self.jwtToken ?? "", forHTTPHeaderField: "x-access-token")
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response<ImageUploadResponse>.self, from: data)
                    completion(.success(response.data))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

extension NetworkManager {
    
    func visualizeDoctorPatientFile(userId: Int, imageId: Int, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.baseURL + APIEndpoints.visualizeDoctorPatientFile(userId: userId, imageId: imageId)) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue(self.jwtToken ?? "", forHTTPHeaderField: "x-access-token")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response<ImageDataResponse>.self, from: data)
                    
                    guard let base64String = decodedResponse.data.data else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No base64 data found"])))
                        return
                    }
                    
                    // Convert base64 string to UIImage
                    if let imageData = Data(base64Encoded: base64String) {
                        let image = UIImage(data: imageData)
                        completion(.success(image))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert base64 string to UIImage"])))
                    }
                    
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
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

struct ImageDataResponse: Codable {
    let data: String?
    let message: String
    let status: Int
    let success: Bool
}


struct ImageUploadResponse: Codable {
    let creationDate: String
    let element: String
    let id: Int
    let imageId: Int
    let lastUpdate: String
    let precision: Double
    let status: Bool
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case creationDate = "creation_date"
        case element
        case id
        case imageId = "image_id"
        case lastUpdate = "last_update"
        case precision
        case status
        case userId = "user_id"
    }
}
