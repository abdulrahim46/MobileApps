//
//  MobileDetail.swift
//  MobileApps
//
//  Created by Abdul Rahim on 15/10/21.
//

import Foundation

struct MobileDetail: Codable {
    let id: Int?
    let image: String?
    let mobileId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case image = "url"
        case mobileId = "mobile_id"
    }
}
