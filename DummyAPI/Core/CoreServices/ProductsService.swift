//
//  ProductsService.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 13/02/2023.
//

import Foundation
import Combine

public protocol ProductsService {
    func getProducts() -> AnyPublisher<[Product], RESTError>
    func searchProducts(input: String) -> AnyPublisher<[Product], RESTError>
}

public final class DefaultProductsService: ProductsService {
    private let restService: RESTService
    
    public init(
        restService: RESTService
    ) {
        self.restService = restService
    }
    
    public func getProducts() -> AnyPublisher<[Product], RESTError> {
        let request = ProductsRESTRequest.getProducts
        let publisher: AnyPublisher<ProductsResponse, RESTError> = restService.execute(request)
        return publisher
            .map { $0.products.map { Product(dto: $0) } }
            .eraseToAnyPublisher()
    }
    
    public func searchProducts(input: String) -> AnyPublisher<[Product], RESTError> {
        let request = ProductsRESTRequest.searchProduct(input)
        let publisher: AnyPublisher<ProductsResponse, RESTError> = restService.execute(request)
        return publisher
            .map { $0.products.map { Product(dto: $0) } }
            .eraseToAnyPublisher()
    }
}

private struct ProductsResponse: Decodable {
    let products: [DTO.Product]
}
