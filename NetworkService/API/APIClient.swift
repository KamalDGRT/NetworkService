//
//  APIClient.swift
//  NetworkService
//
//  Created by Kamal Sharma on 02/03/25.
//

public struct APIClient {
    private var baseUrl: String
    private var networkService: NetworkService
    
    private init(
        baseUrl: String,
        networkService: NetworkService
    ) {
        self.baseUrl = baseUrl
        self.networkService = networkService
    }
    
    ///    Why this function exists: To prevent copying the values to another instance
    ///   `let apiClientInstance = APIClient.create(value: 42)`
    ///   `let anotherClientInstance = instance // This line would cause a compilation error`
    public static func configure(
        baseUrl: String,
        networkService: NetworkService
    ) -> APIClient {
        return APIClient(
            baseUrl: baseUrl,
            networkService: networkService
        )
    }
}

// MARK: HTTP Request Methods
public extension APIClient {
    func get<T: Codable>(
        endPoint: String,
        urlQueryParameters: StringDictionary? = nil,
        requestHeaders: StringDictionary? = nil,
        apiSuccess: @escaping(ApiSuccessResponse<T>),
        apiFailure: @escaping(ApiErrorResponse)
    ) {
        let getRequest = ApiRequest(
            method: .get,
            baseUrl: baseUrl,
            endPoint: endPoint,
            requestHeaders: requestHeaders,
            urlQueryParameters: urlQueryParameters
        )
        networkService.request(
            getRequest,
            apiSuccess: apiSuccess,
            apiFailure: apiFailure
        )
    }
    
    func post<T: Codable>(
        endPoint: String,
        urlQueryParameters: StringDictionary? = nil,
        requestBody: JsonDictionary? = nil,
        formData: StringDictionary? = nil,
        requestHeaders: StringDictionary? = nil,
        apiSuccess: @escaping(ApiSuccessResponse<T>),
        apiFailure: @escaping(ApiErrorResponse)
    ) {
        let postRequest = ApiRequest(
            method: .post,
            baseUrl: baseUrl,
            endPoint: endPoint,
            requestHeaders: requestHeaders,
            requestBody: requestBody,
            urlQueryParameters: urlQueryParameters,
            formData: formData
        )
        networkService.request(
            postRequest,
            apiSuccess: apiSuccess,
            apiFailure: apiFailure
        )
    }
    
    func put<T: Codable>(
        endPoint: String,
        urlQueryParameters: StringDictionary? = nil,
        requestBody: JsonDictionary? = nil,
        formData: StringDictionary? = nil,
        requestHeaders: StringDictionary? = nil,
        apiSuccess: @escaping(ApiSuccessResponse<T>),
        apiFailure: @escaping(ApiErrorResponse)
    ) {
        let putRequest = ApiRequest(
            method: .put,
            baseUrl: baseUrl,
            endPoint: endPoint,
            requestHeaders: requestHeaders,
            requestBody: requestBody,
            urlQueryParameters: urlQueryParameters,
            formData: formData
        )
        networkService.request(
            putRequest,
            apiSuccess: apiSuccess,
            apiFailure: apiFailure
        )
    }
    
    func patch<T: Codable>(
        endPoint: String,
        urlQueryParameters: StringDictionary? = nil,
        requestBody: JsonDictionary? = nil,
        formData: StringDictionary? = nil,
        requestHeaders: StringDictionary? = nil,
        apiSuccess: @escaping(ApiSuccessResponse<T>),
        apiFailure: @escaping(ApiErrorResponse)
    ) {
        let patchRequest = ApiRequest(
            method: .patch,
            baseUrl: baseUrl,
            endPoint: endPoint,
            requestHeaders: requestHeaders,
            requestBody: requestBody,
            urlQueryParameters: urlQueryParameters,
            formData: formData
        )
        networkService.request(
            patchRequest,
            apiSuccess: apiSuccess,
            apiFailure: apiFailure
        )
    }
    
    func delete<T: Codable>(
        endPoint: String,
        urlQueryParameters: StringDictionary? = nil,
        requestBody: JsonDictionary? = nil,
        formData: StringDictionary? = nil,
        requestHeaders: StringDictionary? = nil,
        apiSuccess: @escaping(ApiSuccessResponse<T>),
        apiFailure: @escaping(ApiErrorResponse)
    ) {
        let deleteRequest = ApiRequest(
            method: .delete,
            baseUrl: baseUrl,
            endPoint: endPoint,
            requestHeaders: requestHeaders,
            requestBody: requestBody,
            urlQueryParameters: urlQueryParameters,
            formData: formData
        )
        networkService.request(
            deleteRequest,
            apiSuccess: apiSuccess,
            apiFailure: apiFailure
        )
    }
}
