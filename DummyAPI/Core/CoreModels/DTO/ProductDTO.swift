//
//  ProductDTO.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 13/02/2023.
//

import Foundation

public extension DTO {
    struct Product: Decodable {
        public let id: Int
        public let title: String
        public let thumbnail: URL
        public let brand: String
        public let price: Decimal
    }
}
