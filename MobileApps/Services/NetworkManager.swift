//
//  NetworkManager.swift
//  MobileApps
//
//  Created by Abdul Rahim on 11/10/21.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    
    func request<T: Codable>(urlName:ServiceURLType, expecting: T.Type, completion: @escaping(Result<T, Error>) -> Void ) {
        
        let urlString = URLManager.getUrlString(for: urlName)
        let completeUrl = URL(string: urlString)
        guard let url = completeUrl else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
}
