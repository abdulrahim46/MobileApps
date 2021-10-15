//
//  DataProvider.swift
//  MobileApps
//
//  Created by Abdul Rahim on 11/10/21.
//

import Foundation

protocol DataProvider {
    func request<T: Codable>(urlName:ServiceURLType, expecting: T.Type, completion: @escaping(Result<T, Error>) -> Void)
}
