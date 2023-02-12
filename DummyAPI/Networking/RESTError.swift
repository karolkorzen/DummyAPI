//
//  RESTError.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation

public enum RESTError: Error {
    case wrongStatusResponse(Int, APIError?)
    case noInternetConnection
    case unknown
    case customError(Error)
}

public struct APIError: Decodable {
    public let message: String?
}
