//
//  APIRequest.swift
//  NetworkService
//
//  Created by Kamal Sharma on 02/03/25.
//

import Foundation

public struct ApiRequest {
    /// The HTTP request method to use for this request.
    var method: HTTPMethod
    
    /// The url of the API server. Example: `https://yourapp.com`
    var baseUrl: String
    
    /// The endpoint resource of this API request e.g. `scheme://host<RESOURCE>` where <RESOURCE> could be `/info`, etc. NOTE: The preceding forward slash is required.
    var endPoint: String
    
    /// Optional headers to include in your request.
    var requestHeaders: StringDictionary?
    
    /// The request body that will be sent. Mostly used for POST/PUT/PATCH calls
    var requestBody: JsonDictionary?
    
    /// The URL query parameters of this request, if any.
    var urlQueryParameters: StringDictionary?
    
    /// The form data for request type where the content is of type `application/x-www-form-urlencoded`
    var formData: StringDictionary? = nil
    
    public init(
        method: HTTPMethod,
        baseUrl: String,
        endPoint: String,
        requestHeaders: StringDictionary? = nil,
        requestBody: JsonDictionary? = nil,
        urlQueryParameters: StringDictionary? = nil,
        formData: StringDictionary? = nil
    ) {
        self.method = method
        self.baseUrl = baseUrl
        self.endPoint = endPoint
        self.requestHeaders = requestHeaders
        self.requestBody = requestBody
        self.urlQueryParameters = urlQueryParameters
        self.formData = formData
    }
    
    public func toString() -> String {
        var str = "{\n"
        str += "method: " + method.rawValue + ",\n"
        str += "baseUrl: " + baseUrl + ",\n"
        str += "endPoint: " + endPoint + ",\n"
        str += "requestHeaders: " + (requestHeaders?.toJsonString ?? "") + ",\n"
        str += "requestBody: " + (requestBody?.toJsonString ?? "") + ",\n"
        str += "urlQueryParameters: " + (urlQueryParameters?.toJsonString ?? "") + ",\n"
        str += "formData: " + (formData?.toJsonString ?? "") + "\n"
        str += "}\n"
        return str
    }
    
    public func url() -> URL? {
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.path = endPoint
        
        /// adding query params
        if let queryParams = urlQueryParameters {
            urlComponents?.queryItems = queryParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        return urlComponents?.url
    }
    
    public func httpBody() -> Data? {
        let isFormUrlEncoded = requestHeaders?.isFormUrlEncoded() ?? false
        let formUrlData = formData?.urlEncodedString.data(using: .utf8)
        let requestBodyData = requestBody?.jsonData
        return isFormUrlEncoded ? formUrlData : requestBodyData
    }
}
