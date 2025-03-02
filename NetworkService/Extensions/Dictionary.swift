//
//  Dictionary.swift
//  NetworkService
//
//  Created by Kamal Sharma on 02/03/25.
//

import Foundation

extension Dictionary {
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
    
    var toJsonString: String {
        return jsonData?.toString ?? "{}"
    }
}
