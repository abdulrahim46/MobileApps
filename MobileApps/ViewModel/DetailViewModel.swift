//
//  DetailViewModel.swift
//  MobileApps
//
//  Created by Abdul Rahim on 17/10/21.
//

import Foundation

class DetailViewModel {
    
    //MARK:- Properties & View
    var details = [MobileDetail]()
    var apiResource: DataProvider
    
    init(apiResource: DataProvider = NetworkManager()) {
        self.apiResource = apiResource
    }
    
    
    /// fetch mobiles from server
    func getAllImages(id: String, completion: @escaping ([MobileDetail]?, Error?) -> Void) {
        apiResource.request(urlName: .details(id), expecting: [MobileDetail].self) { [weak self] result in
            switch result {
            case .success(let mobiles):
                completion(mobiles, nil)
                self?.details = mobiles
            case .failure(let error):
                completion(nil,error)
                AlertBuilder.failureAlertWithMessage(message: error.localizedDescription)
            }
        }
    }
}
