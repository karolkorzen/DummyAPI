//
//  MapResult.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Combine
import Foundation

public extension Publisher {
    func mapResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        map(Result.success)
            .catch { Just(Result.failure($0)) }
            .eraseToAnyPublisher()
    }
}
