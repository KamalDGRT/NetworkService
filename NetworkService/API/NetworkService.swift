//
//  NetworkService.swift
//  NetworkService
//
//  Created by Kamal Sharma on 02/03/25.
//

import UIKit

/// Global Function to print the description provided by the `APIError` along with the status code.
public func apiErrorDescription(_ error: ApiError, _ statusCode: Int) -> String {
    var str = "\n" + "-".repeatString(10) + "\n"
    str += "Error: " + error.description + "\n\n"
    str += "Status Code: \(statusCode) - "
    str += "\n" + "-".repeatString(10) + "\n"
    return str
}

public struct NetworkService {
    /// Default headers to include in your request. You can set this preferably in the `AppDelegate`.
    public var defaultHeaders: StringDictionary?
    
    /// With this, you can set your own configuration for the Network Calls in your `AppDelegate`.
    public var urlSessionConfig: URLSessionConfiguration?
    
    // This initialiser would be used when you want to connect to different
    public init(
        defaultHeaders: StringDictionary? = nil,
        urlSessionConfig: URLSessionConfiguration = .default
    ) {
        self.defaultHeaders = defaultHeaders
        self.urlSessionConfig = urlSessionConfig
    }
    
    private var urlSession: URLSession {
        if let urlSessionConfig {
            return URLSession(configuration: urlSessionConfig)
        } else {
            let config = URLSessionConfiguration.default
            config.tlsMinimumSupportedProtocolVersion = .TLSv13
            config.urlCache = nil
            
            return URLSession(configuration: config)
        }
    }
    
    public func request<T: Codable>(
        _ apiRequest: ApiRequest,
        apiSuccess: @escaping(ApiSuccessResponse<T>),
        apiFailure: @escaping(ApiErrorResponse)
    ) {
        guard let webRequest = prepareUrlRequest(apiRequest, apiFailure) else { return }
        
        let dataTask = urlSession.dataTask(with: webRequest) { (data, response, error) in
            DispatchQueue.main.async {
                processUrlResponse(data, response, error, apiSuccess, apiFailure)
            }
        } // urlSession
        dataTask.resume()
    } // request
    
    
    /// Asynchronously downloads an image from a URL.
    ///
    /// - Parameter urlString: The URL string from which to download the image.
    /// - Returns: A `UIImage` object representing the downloaded image.
    /// - Throws: An error if the URL is invalid or if there's an issue with downloading or decoding the image data.
    public func asyncImageDownload(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw ApiError.malformedUrl
        }
        
        let data = try? await urlSession.data(from: url)
        
        guard let data else {
            throw ApiError.decoding
        }
        
        guard let image = UIImage(data: data.0) else {
            throw ApiError.decoding
        }
        
        return image
    }
}

private extension NetworkService {
    func getRequestHeaders(_ apiRequestHeaders: StringDictionary?) -> StringDictionary {
        var requestHeaders = StringDictionary()
        /// Default Request Headers
        if let defaultRequestHeaders = defaultHeaders {
            for reqHead in defaultRequestHeaders {
                requestHeaders[reqHead.key.lwr()] = reqHead.value
            }
        }
        /// Request Headers that are sent in the specific API endpoint call which can be used to override the default headers.
        if let reqHeaders = apiRequestHeaders {
            for reqHead in reqHeaders {
                requestHeaders[reqHead.key.lwr()] = reqHead.value
            }
        }
        
        return requestHeaders
    }
    
    func prepareUrlRequest(
        _ apiRequest: ApiRequest,
        _ apiFailure: @escaping(ApiErrorResponse)
    ) -> URLRequest? {
        /// creating the actual Swift-Style API Request
        // Construct our web request.
        guard apiRequest.baseUrl.isNotBlank else {
            apiFailure(.emptyBaseUrl, 400)
            return nil
        }
        
        guard let endpointUrl = apiRequest.url() else {
            apiFailure(.malformedUrl, 400)
            return nil
        }
        
        var webRequest = URLRequest(url: endpointUrl)
        webRequest.httpMethod = apiRequest.method.rawValue
        webRequest.httpBody = apiRequest.httpBody()
        webRequest.cachePolicy = .useProtocolCachePolicy
        webRequest.timeoutInterval = 120
        webRequest.allHTTPHeaderFields = getRequestHeaders(apiRequest.requestHeaders)
        return webRequest
    }
    
    func processUrlResponse<T: Codable>(
        _ data: Data?,
        _ response: URLResponse?,
        _ error: (any Error)?,
        _ apiSuccess: @escaping(ApiSuccessResponse<T>),
        _ apiFailure: @escaping(ApiErrorResponse)
    ) {
        guard let apiResponse = response as? HTTPURLResponse else {
            apiFailure(.invalidResponse, 400)
            return
        }
        
        /// Api call succeeded
        if apiResponse.statusCode >= 200 &&
            apiResponse.statusCode < 399 &&
            error == nil {
            /// Handling error  while parsing the data
            guard let responseData: T = data?.jsonDecoder() else {
                apiFailure(.decoding, 400)
                return
            }
            apiSuccess(responseData, apiResponse.statusCode)
        } else if let jsonData = data {
            apiFailure(.serverErrorWithData(data: jsonData), apiResponse.statusCode)
            return
        } else {
            /// no data and failure implies internal server error
            apiFailure(.internalServerError, apiResponse.statusCode)
            return
        }
    }
}
