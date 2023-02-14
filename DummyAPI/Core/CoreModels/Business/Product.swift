//
//  Product.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 13/02/2023.
//

import Foundation

public struct Product {
    public let id: Int
    public let title: String
    public let thumbnail: URL
    public let brand: String
    public let price: Decimal
    
    public init(dto: DTO.Product) {
        id = dto.id
        title = dto.title
        thumbnail = dto.thumbnail
        brand = dto.brand
        price = dto.price
    }
}
