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
        
        /**
        Retrieves the current user's data.

        This function sends a GET request to the "/get_user_data" endpoint. If the request is successful, it decodes the response into a `User` object. In case of failure, it returns an error.

        - Parameters:
           - completion: A closure that gets called when the request is complete, returning a `Result` with a `User` upon success or an `Error` upon failure.

        - Returns: Void
        */
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-access-token": self.jwtToken ?? ""
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
