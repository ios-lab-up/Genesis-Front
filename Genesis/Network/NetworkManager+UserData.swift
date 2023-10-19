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

        
        
    }
