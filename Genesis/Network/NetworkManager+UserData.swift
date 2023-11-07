//
//  NetworkManager+UserData.swift
//  Genesis
//
//  Created by Luis Cedillo M on 17/10/23.
//

import Foundation
import Alamofire

extension NetworkManager {
    
    func getUserData(completion: @escaping (Result<User, Error>) -> Void) {
        
        // Check if the token exists
        guard let token = retrieveToken() else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Authentication token is missing"])))
            return
        }

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-access-token": token // Here we're using the non-optional token
        
            
        ]
        
        AF.request(APIEndpoints.getUserData, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Response<User>.self) { response in
                switch response.result {
                case .success(let userDataResponse):
                    completion(.success(userDataResponse.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    

    func getUser2UserRelations(completion: @escaping (Result<[User], Error>) -> Void) {
        
        // Check if the token exists
        guard let token = retrieveToken() else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Authentication token is missing"])))
            return
        }

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-access-token": token // Here we're using the non-optional token
            
        ]
        

        AF.request(APIEndpoints.getUser2UserRelations, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Response<[User]>.self) { response in
                switch response.result {
                case .success(let userDataResponse):
                    completion(.success(userDataResponse.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getUserImages(completion: @escaping (Result<[ImageData], Error>) -> Void) {
        // Check if the token exists
        guard let token = retrieveToken() else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Authentication token is missing"])))
            return
        }

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-access-token": token // Here we're using the non-optional token
        ]
        
        // Use Alamofire to make a network request
        AF.request(APIEndpoints.getUserImages, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Response<Dictionary<String, [ImageData]>>.self) { response in
                switch response.result {
                case .success(let responseData):
                    // Assuming 'images' is the key for the array of ImageData within the 'data' dictionary
                    if let images = responseData.data["images"] {
                        completion(.success(images))
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data parsing error: 'images' key not found"])))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    
    func fetchAllUserData(completion: @escaping (Result<(User, [User], [ImageData]), Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        var userData: User?
        var userRelations: [User]?
        var userImages: [ImageData]?
        var firstError: Error?
        
        dispatchGroup.enter()
        getUserData { result in
            switch result {
            case .success(let user):
                userData = user
            case .failure(let error):
                firstError = error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getUser2UserRelations { result in
            switch result {
            case .success(let relations):
                userRelations = relations
            case .failure(let error):
                if firstError == nil { // Only capture the first error encountered
                    firstError = error
                }
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
            getUserImages { result in
                switch result {
                case .success(let images):
                    userImages = images
                case .failure(let error):
                    if firstError == nil { // Only capture the first error encountered
                        firstError = error
                    }
                }
                dispatchGroup.leave()
            }
        
        dispatchGroup.notify(queue: .main) {
            if let user = userData, let relations = userRelations, let images = userImages {
                // Update the GlobalDataModel with the fetched data
                GlobalDataModel.shared.user = user
                GlobalDataModel.shared.userRelations = relations
                GlobalDataModel.shared.userImages = images
                completion(.success((user, relations, images)))
            } else if let error = firstError {
                completion(.failure(error))
            } else {
                // Handle unexpected error
                let unexpectedError = NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "An unexpected error occurred"])
                completion(.failure(unexpectedError))
            }
        }
        
        print("fetching all user data")
    }

    }
