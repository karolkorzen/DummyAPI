//
//  RESTService.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Combine
import Foundation

// MARK: - RESTService

public protocol RESTService {
    func execute<T: Decodable>(_ request: RESTRequest, decoder: JSONDecoder) -> AnyPublisher<T, RESTError>
}

// Provides default parameters for interface
public extension RESTService {
    func execute<T: Decodable>(
        _ request: RESTRequest,
        decoder: JSONDecoder = .simpleDecoder
    ) -> AnyPublisher<T, RESTError> {
        execute(request, decoder: decoder)
    }
}

// MARK: - RESTNetworkService

public struct RESTNetworkService: RESTService {
    let session: URLSession
    
    /// RESTNetworkService initialization.
    /// - Parameters:
    ///   - session: URLSession used to trigger requests
    public init(
        session: URLSession
    ) {
        self.session = session
    }
    
    /// Executes provided request and tries to decode generic T object.
    /// - Parameters:
    ///   - request: RESTRequest to execute.
    ///   - decoder: JSONDecoder used to decode T object. By default .simpleDecoder
    /// - Returns: Publisher with T output and RESTError as a failure type.
    public func execute<T: Decodable>(
        _ request: RESTRequest,
        decoder: JSONDecoder
    ) -> AnyPublisher<T, RESTError> {
        session
            .dataTaskPublisher(for: request.urlRequest)
            .throwRESTErrorIfIncorrectResponse(decoder: decoder)
            .decode(type: T.self, decoder: decoder)
            .mapError {$0 as? RESTError ?? .unknown }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
