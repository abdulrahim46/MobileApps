//
//  ApiMockResources.swift
//  MobileAppsTests
//
//  Created by Abdul Rahim on 17/10/21.
//

import Foundation

@testable import MobileApps

struct ApiMockResources: DataProvider {
    
    
    
    /// mock func for get mobiles
    func request<T>(urlName: ServiceURLType, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        let urlString = URLManager.getUrlString(for: urlName)
        let completeUrl = URL(string: urlString)
        guard let url = completeUrl else {
            completion(.failure(NetworkManager.CustomError.invalidUrl))
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkManager.CustomError.invalidData))
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
