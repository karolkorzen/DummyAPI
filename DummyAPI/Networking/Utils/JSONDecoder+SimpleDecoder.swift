//
//  JSONDecoder.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation

public extension JSONDecoder {
    static let simpleDecoder: JSONDecoder = {
        JSONDecoder()
    }()
}
