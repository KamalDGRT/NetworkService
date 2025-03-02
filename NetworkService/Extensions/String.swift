//
//  String.swift
//  NetworkService
//
//  Created by Kamal Sharma on 02/03/25.
//

import Foundation

extension String {
    /// This is a wrapper around the built-in `.lowercased()` function.
    /// - Returns: lower-cased version of the current string
    func lwr() -> String {
        self.lowercased()
    }
    
    func repeatString(_ times: Int) -> String {
        return String(repeating: self, count: times)
    }
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    var isNotBlank: Bool {
        get {
            return !self.isBlank
        }
    }
}
