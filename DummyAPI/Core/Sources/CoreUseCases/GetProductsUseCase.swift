//
//  GetProductsUseCase.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 13/02/2023.
//

import Foundation
import Combine
import CoreModels
import Networking
import CoreServices

public protocol GetProductsUseCase {
    func execute() -> AnyPublisher<[Product], RESTError>
}

public final class DefaultGetProductsUseCase: GetProductsUseCase {
    private let productsService: ProductsService
    
    public init(productsService: ProductsService) {
        self.productsService = productsService
    }
    
    public func execute() -> AnyPublisher<[Product], RESTError> {
        productsService.getProducts()
    }
}
