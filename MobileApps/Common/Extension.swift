//
//  Extension.swift
//  MobileApps
//
//  Created by Abdul Rahim on 11/10/21.
//

import Foundation


extension Notification.Name {
    static let fetchDataFromFirestore = Notification.Name("fetchDataFromFirestore")
}

extension JSONDecoder {
    func decode<T>(_ type: T.Type, fromJSONObject object: Any) throws -> T where T: Decodable {
        return try decode(T.self, from: try JSONSerialization.data(withJSONObject: object, options: []))
    }
}


extension Optional where Wrapped == String {

    var orEmpty: String {
        return self ?? ""
    }

    var notEmpty: Bool {
        return !isEmpty
    }

    var isEmpty: Bool {
        return self.orEmpty.isEmpty
    }

    var orDash: String {
        return (self != nil && self.notEmpty) ? self.orEmpty : "-"
    }

    var orZero: String {
        return self ?? "0"
    }
}

extension Optional where Wrapped == Double {
    
    var orZero: Double {
        return self ?? 0
    }
}

extension Optional where Wrapped == Int {

    var orZero: Int {
        return self ?? 0
    }
}
