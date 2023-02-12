//
//  HomeDIContainer.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation

public final class HomeModuleDependencies {
    let resolveRESTService: () -> RESTService
    
    public init(
        resolveRESTService: @escaping () -> RESTService
    ) {
        self.resolveRESTService = resolveRESTService
    }
}

public protocol HomeDIContainer {
    
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
    
}

//MARK: - Use Cases
extension DefaultHomeDIContainer {
    
}

//MARK: - Services
extension DefaultHomeDIContainer {
    
}
