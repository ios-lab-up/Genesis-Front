//
//  NetworkManager+UserAuth.swift
//  Genesis
//
//  Created by Luis Cedillo M on 17/10/23.
//

import Foundation
import Alamofire



extension NetworkManager {
    
    
    
    func signUp(name: String, username: String, email: String, password: String, birthDate: String, profileId: Int, cedula: String? = nil, completion: @escaping (Result<User, Error>) -> Void) {
        
        /**
         Creates a new user account with the specified information.
         
         This function sends a POST request to the sign-up endpoint with the user's information. If the request is successful, it decodes the response into a `User` object and saves the JWT token. In case of failure, it returns an error.
         
         - Parameters:
         - name: The full name of the user.
         - username: The username chosen by the user.
         - email: The user's email address.
         - password: The user's password.
         - birthDate: The user's birthdate, as a string.
         - profileId: An identifier associated with the user's profile.
         - cedula: An optional identification number for the user. Defaults to `nil`.
         - completion: A closure that gets called when the request is complete. If the request is successful, it returns a `Result` with a `User`. If the request fails, it returns a `Result` with an `Error`.
         
         - Returns: Void
         */
        
        var parameters: [String: Any] = [
            "name": name,
            "username": username,
            "email": email,
            "password": password,
            "birth_date": birthDate,
            "profile_id": profileId
        ]
        
        if let cedulaValue = cedula {
            parameters["cedula"] = cedulaValue
        }
        
        AF.request(APIEndpoints.signUp, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { response in
                // Switch over response result
                switch response.result {
                case .success(let data):
                    // If the request is successful, decode the response
                    do {
                        let decoder = JSONDecoder()
                        let decodedResponse = try decoder.decode(APIResponse<User>.self, from: data!)
                        
                        // Check if 'success' is true in the response
                        if decodedResponse.success {
                            // Handle successful response
                            if let token = decodedResponse.data?.jwtToken {
                                self.saveToken(token)
                                self.isAuthenticated = true
                                self.jwtToken = token

                            }
                            
                            completion(.success(decodedResponse.data!))
                        } else {
                            // If 'success' is false, handle the error message from the response
                            let errorMessage = decodedResponse.message ?? "An unknown error occurred"
                            let error = NSError(domain: "", code: decodedResponse.status ?? 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                            completion(.failure(error))
                        }
                    } catch {
                        // Handle decoding error
                        completion(.failure(error))
                    }
                    
                case .failure:
                    // If the request fails, check if it's because of an unacceptable status code
                    if let afError = response.error, afError.isResponseValidationError, let data = response.data {
                        // Decode the error response from the server
                        do {
                            let decoder = JSONDecoder()
                            let errorResponse = try decoder.decode(APIResponse<ErrorResponse>.self, from: data)
                            
                            // Constructing a detailed error message using both 'error' and 'message' from the response
                            var detailedErrorMessage = errorResponse.error ?? "An error occurred"
                            if let message = errorResponse.message {
                                detailedErrorMessage += ": \(message)"
                            }
                            
                            let error = NSError(domain: "", code: errorResponse.status ?? 0, userInfo: [NSLocalizedDescriptionKey: detailedErrorMessage])
                            completion(.failure(error))
                        } catch {
                            // Handle decoding error
                            completion(.failure(error))
                        }
                    } else if let error = response.error {
                        // Handle other errors
                        completion(.failure(error))
                    }
                }
            }
        
    }
    
    func verifyIdentity(code: String, completion: @escaping (Result<User, Error>) -> Void) {
        /**
         Verifies the identity of a user with a provided code.
         
         This function sends a POST request to the verify-identity endpoint, including the user's unique code in the request body. Upon success, it decodes the response, updates the authentication status, and returns a `User` object. In case of failure, it returns an error.
         
         - Parameters:
         - code: The unique code associated with the user's account, used for identity verification.
         - completion: A closure that gets called when the request is complete. If the request is successful, it returns a `Result` with a `User`. If the request fails, it returns a `Result` with an `Error`.
         
         - Returns: Void
         */
        
        
        // Headers
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-access-token": self.jwtToken ?? ""
        ]
        
        // Parameters
        let parameters: [String: Any] = ["code": code]
        
        // Alamofire Request
        AF.request(APIEndpoints.verifyIdentity, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .response { response in
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let decodedResponse = try decoder.decode(APIResponse<User>.self, from: data)
                        
                        if let userData = decodedResponse.data, decodedResponse.success == true {
                            self.isAuthenticated = true // or use decodedResponse.success if it's not always true on success
                            completion(.success(userData))
                        } else {
                            let errorMessage = decodedResponse.message ?? "An unknown error occurred"
                            let error = NSError(domain: "", code: decodedResponse.status ?? 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                            completion(.failure(error))
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
    }
    func resendVerificationCode(completion: @escaping (Result<Bool, Error>) -> Void) {
        
        /**
         Requests to resend a user's verification code.
         
         This function sends a GET request to the resend-verification-code endpoint. It uses the saved JWT token for authentication. If the request encounters an error, it returns the error; otherwise, it decodes the response into a `Response` object and checks for success. If the response indicates success, it returns true; otherwise, it returns an error.
         
         - Parameters:
         - completion: A closure that gets called when the request is complete. If the request is successful, it returns a `Result` with a boolean value set to `true`. If the request fails, it returns a `Result` with an `Error`.
         
         - Returns: Void
         */
        
        let headers: HTTPHeaders = [
            "x-access-token": self.jwtToken ?? ""
        ]
        
        AF.request(APIEndpoints.resendVerificationCode, method: .get, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(APIResponse<Bool>.self, from: data)
                    
                    // If the 'success' field is true, we can complete with success. The actual 'data' field is not used here because a successful verification code resend might not return meaningful data.
                    if decodedResponse.success {
                        completion(.success(true))
                    } else {
                        // If 'success' is false, we create an error with the provided message or a default one if the message is not available.
                        let errorMessage = decodedResponse.message ?? "An unknown error occurred"
                        let error = NSError(domain: "", code: decodedResponse.status ?? 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        completion(.failure(error))
                    }
                    
                } catch {
                    // Handle decoding error
                    completion(.failure(error))
                }
                
            case .failure(let error):
                // Handle request error
                completion(.failure(error))
            }
        }
        
    }
    
    
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(APIEndpoints.signIn, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: APIResponse<User>.self) { response in
                switch response.result {
                case .success(let decodedResponse):
                    if decodedResponse.success, let userData = decodedResponse.data {
                        if let token = decodedResponse.data?.jwtToken {
                            self.saveToken(token)
                            self.isAuthenticated = true

                        }
                        completion(.success(userData))
                        
                    } else {
                        let errorMessage = decodedResponse.message ?? "An unknown error occurred"
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}


