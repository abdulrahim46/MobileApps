//
//  URLManager.swift
//  MobileApps
//
//  Created by Abdul Rahim on 11/10/21.
//

import Foundation

struct URLManager {
    
    static let kBaseURL = "https://scb-test-mobile.herokuapp.com"
    static let kGetMobiles = "/api/mobiles/"
    //static let kGetMobileDetails = "/api/mobiles/1/images/"
    
    static func getUrlString(for serviceEnum: ServiceURLType)-> String {
        switch serviceEnum {
        case .mobiles:
            return kBaseURL + kGetMobiles
        case .details(let id):
            return kBaseURL + kGetMobiles + id + "/images/"
        }
    }
    
}


enum ServiceURLType {
    case mobiles
    case details(String)
}
