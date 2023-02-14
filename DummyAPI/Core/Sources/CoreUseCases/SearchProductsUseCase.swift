//
//  SearchProductsUseCase.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 13/02/2023.
//

import Foundation
import Combine
import CoreModels
import Networking
import CoreServices

public protocol SearchProductsUseCase {
    func execute(input: String) -> AnyPublisher<[Product], RESTError>
}

public final class DefaultSearchProductsUseCase: SearchProductsUseCase {
    private let productsService: ProductsService
    
    public init(productsService: ProductsService) {
        self.productsService = productsService
    }
    
    public func execute(input: String) -> AnyPublisher<[Product], RESTError> {
        productsService.searchProducts(input: input)
    }
}
