//
//  AllMobileViewModel.swift
//  MobileApps
//
//  Created by Abdul Rahim on 15/10/21.
//

import Foundation

class AllMobileViewModel {
    
    var mobiles = [Mobile]()
    var apiResource: DataProvider
    
    init(apiResource: DataProvider = NetworkManager()) {
        self.apiResource = apiResource
        //getAllMobiles()
    }
    
    /// fetch mobiles from server
    func getAllMobiles(completion: @escaping ([Mobile]?, Error?) -> Void) {
        apiResource.request(urlName: .mobiles, expecting: [Mobile].self) { [weak self] result in
            switch result {
            case .success(let mobiles):
                completion(mobiles, nil)
                self?.mobiles = mobiles
            case .failure(let error):
                completion(nil,error)
                AlertBuilder.failureAlertWithMessage(message: error.localizedDescription)
            }
        }
    }
}
