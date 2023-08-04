//
//  NetworkManager.swift
//  Genesis
//
//  Created by Luis Cedillo M on 24/07/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    var sixDigitCode: String?
    var jwtToken: String?
    private init() {}

    func signUp(name: String, username: String, email: String, password: String, birthDate: String, profileId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "https://f909-189-147-103-182.ngrok-free.app/sign_up") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["name": name, "username": username, "email": email, "password": password, "birth_date": birthDate, "profile_id": profileId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
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
        let url = URL(string: "https://f909-189-147-103-182.ngrok-free.app/sign_up/verify_identity")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.jwtToken ?? "", forHTTPHeaderField: "x-access-token" )
        let body = ["code": code]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                if let response = try? decoder.decode(Response.self, from: data) {
                    completion(.success(response.data))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to decode response"])
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func resendVerificationCode(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "https://f909-189-147-103-182.ngrok-free.app/sign_up/resend_verification_code") else {
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

}

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let birthDate: String
    let cedula: String?
    let creationDate: String
    let jwtToken: String
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

struct Response: Codable {
    let data: User
    let message: String
    let status: Int
    let success: Bool
}
