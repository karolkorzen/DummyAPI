//
//  HomeDIContainer.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation
import CoreServices
import CoreUseCases
import Networking
import SwiftUI

public final class HomeModuleDependencies {
    let resolveRESTService: () -> RESTService
    
    public init(
        resolveRESTService: @escaping () -> RESTService
    ) {
        self.resolveRESTService = resolveRESTService
    }
}

public protocol HomeDIContainer {
    func resolve() -> DefaultMainSceneInteractor
}

//MARK: - DefaultHomeDIContainer
public final class DefaultHomeDIContainer: HomeDIContainer {
    private let dependencies: HomeModuleDependencies
    
    public init(dependencies: HomeModuleDependencies) {
        self.dependencies = dependencies
    }
}

//MARK: - Interactors
extension DefaultHomeDIContainer {
    public func resolve() -> DefaultMainSceneInteractor {
        DefaultMainSceneInteractor(
            getProductsUseCase: resolve(),
            searchProductsUseCase: resolve()
        )
    }
}

//MARK: - Use Cases
extension DefaultHomeDIContainer {
    private func resolve() -> GetProductsUseCase {
        DefaultGetProductsUseCase(productsService: resolve())
    }
    
    private func resolve() -> SearchProductsUseCase {
        DefaultSearchProductsUseCase(productsService: resolve())
    }
}

//MARK: - Services
extension DefaultHomeDIContainer {
    private func resolve() -> ProductsService {
        DefaultProductsService(restService: dependencies.resolveRESTService())
    }
}
