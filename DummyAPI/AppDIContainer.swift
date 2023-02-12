//
//  AppDIContainer.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation

//MARK: - AppDIContainer
public protocol AppDIContainer {
    func resolve() -> HomeDIContainer
}

//MARK: - DefaultAppDIContainer
public final class DefaultAppDIContainer: AppDIContainer {
    // MARK: Shared instances
    private lazy var urlSession: URLSession = .shared
}

//MARK: - Dependency Injection Containers
extension DefaultAppDIContainer {
    public func resolve() -> HomeDIContainer {
        DefaultHomeDIContainer(
            dependencies: .init(
                resolveRESTService: { [unowned self] in resolve() }
            )
        )
    }
}

// MARK: - Services
public extension DefaultAppDIContainer {
    func resolve() -> RESTService {
        RESTNetworkService(session: urlSession)
    }
}
