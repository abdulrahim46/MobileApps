//
//  Mobile.swift
//  MobileApps
//
//  Created by Abdul Rahim on 15/10/21.
//

import Foundation

struct Mobile: Codable, Hashable {
    let title: String?
    let image: String?
    let description: String?
    let price: Double?
    let rating: Double?
    let id: Int?
    var documentID: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case image = "thumbImageURL"
        case description
        case price
        case rating
        case id
        case documentID
    }
}
