//
//  HTTPMethods.swift
//  NetworkService
//
//  Created by Kamal Sharma on 02/03/25.
//

import Foundation

/// Basic HTTP request methods.
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
