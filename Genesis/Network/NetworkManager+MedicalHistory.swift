//
//  NetworkManager+MedicalHistory.swift
//  Genesis
//
//  Created by Luis Cedillo M on 17/10/23.
//

import Alamofire
import Foundation

extension NetworkManager{
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
        }, to: APIEndpoints.uploadImage, method: .post, headers: headers).responseData { response in
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
