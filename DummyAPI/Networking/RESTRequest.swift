//
//  RESTRequest.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation

// MARK: - RESTRequest

public protocol RESTRequest {
    var scheme: String { get }
    var basePath: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var queryParams: [String: String] { get }
}

public extension RESTRequest {
    var basePath: String {
        AppConfig.current.host
    }
    
    var scheme: String {
        AppConfig.current.scheme
    }
}

extension RESTRequest {
    var urlRequest: URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = basePath
        components.path = endpoint

        if !queryParams.isEmpty {
            components.queryItems = queryParams.map { URLQueryItem(name: $0, value: $1) }
        }

        guard let url = components.url else {
            fatalError("Cannot create URL from provided data")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }
}
