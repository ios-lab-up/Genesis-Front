//
//  NetworkManager.swift
//  Genesis
//
//  Created by Luis Cedillo M on 24/07/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    var token: String?
    private init() {}

    func signUp(name: String, username: String, email: String, password: String, birthDate: String, profileId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "https://a210-189-147-92-102.ngrok-free.app/sign_up") else {
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
                    completion(.success(response.data))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func verifyIdentity(code: String, completion: @escaping (Result<User, Error>) -> Void) {
        let url = URL(string: "https://a210-189-147-92-102.ngrok-free.app/sign_up/verify_identity")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(String(describing: self.token))", forHTTPHeaderField: "Authorization")
        let body = ["code": code]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                if let user = try? decoder.decode(User.self, from: data) {
                    completion(.success(user))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to decode response"])
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
    // Add any other properties that your server returns for a user
}

struct Response: Codable {
    let data: User
    let message: String
    let status: Int
    let success: Bool
}
