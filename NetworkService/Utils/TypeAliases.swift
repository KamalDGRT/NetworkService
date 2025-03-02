//
//  TypeAliases.swift
//  NetworkService
//
//  Created by Kamal Sharma on 02/03/25.
//

import Foundation

public typealias EmptyClosure = () -> Void

public typealias ApiSuccessResponse<T: Codable> = (T, Int) -> Void
public typealias ApiErrorResponse = (ApiError, Int) -> Void

public typealias StringDictionary = [String: String]
public typealias JsonDictionary = [String: Any]
