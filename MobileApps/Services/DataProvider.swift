//
//  DataProvider.swift
//  MobileApps
//
//  Created by Abdul Rahim on 11/10/21.
//

import Foundation

protocol DataProvider {
    func getMobiles() //-> AnyPublisher<News, NetworkManager.APIError>
    func getMobileDetails()
}
