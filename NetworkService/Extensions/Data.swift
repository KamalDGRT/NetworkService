//
//  Data.swift
//  NetworkService
//
//  Created by Kamal Sharma on 02/03/25.
//

import Foundation

extension Data {
    var toString: String {
        return String(data: self, encoding: .utf8) ?? ""
    }
    
    func jsonDecoder<T: Codable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
