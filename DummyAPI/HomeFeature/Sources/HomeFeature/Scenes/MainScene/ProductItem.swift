//
//  ProductItemViewModel.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation
import CommonResources
import CoreModels

public struct ProductItem: Hashable {
    public let id: Int
    public let title: String
    public let thumbnail: URL
    public let brand: String
    public let price: String
    
    public init(_ model: Product, priceFormatter: NumberFormatter) {
        id = model.id
        title = model.title
        thumbnail = model.thumbnail
        brand = L10n.manufacturerLabel + model.brand
        price = priceFormatter.string(from: model.price)
    }
}
