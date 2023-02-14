//
//  DataTaskPublisher+throwRESTErrorIfIncorrectResponse.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation
import Combine

public extension URLSession.DataTaskPublisher {
    func throwRESTErrorIfIncorrectResponse(decoder: JSONDecoder) -> AnyPublisher<Data, RESTError> {
        mapError { error -> RESTError in
            switch error.code {
            case .notConnectedToInternet, .networkConnectionLost: return .noInternetConnection
            default: return .unknown
            }
        }
        .tryMap { data, response in
            let errorData = try? decoder.decode(APIError.self, from: data)

            guard let response = response as? HTTPURLResponse else {
                throw RESTError.unknown
            }

            guard (200 ... 299).contains(response.statusCode) else {
                switch response.statusCode {
                default: throw RESTError.wrongStatusResponse(response.statusCode, errorData)
                }
            }

            return data
        }
        .mapError { ($0 as? RESTError) ?? RESTError.unknown }
        .eraseToAnyPublisher()
    }
}

