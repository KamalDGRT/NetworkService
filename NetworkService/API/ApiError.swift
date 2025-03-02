//
//  ApiError.swift
//  NetworkService
//
//  Created by Kamal Sharma on 02/03/25.
//

import Foundation

/// An error resulting from an operation failing during normal APIClient operation.
public enum ApiError: Error {
    /// The baseUrl for the API call is empty.
    case emptyBaseUrl
    
    /// An error occurred while creating the request body.
    case badRequestBody
    
    /// An error occurred during decoding the API response.
    case decoding
    
    /// A request url was malformed
    case malformedUrl
    
    ///  Error occurred while trying to parse the API response.
    case invalidResponse
    
    ///  Typical Internal Server error.
    case internalServerError
    
    /// API is able to give some response data upon failure.
    case serverErrorWithData(data: Data)
}

extension ApiError: CustomStringConvertible {
    /// Returns a string describing the error.
    public var description: String {
        switch self {
        case .emptyBaseUrl:
            return "The baseUrl for the API call is empty."
        case .badRequestBody:
            return "The request body has not been created in the way the API expects."
        case .decoding:
            return "An error occurred during decoding the API response to a suitable class/struct."
        case .malformedUrl:
            return "The request URL is not proper/valid."
        case .invalidResponse:
            return "The HTTPURLResponse is nil/empty. Unable to unwrap it to a proper response."
        case .internalServerError:
            return "Typical Internal server "
        case .serverErrorWithData(let data):
            return "API call has failed but the server has returned a response.\n\nResponse: \(data.toString)"
        }
    }
}
