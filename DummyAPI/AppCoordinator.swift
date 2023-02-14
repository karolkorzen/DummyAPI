//
//  AppCoordinator.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 15/02/2023.
//

import Foundation
import Coordinator
import UIKit
import HomeFeature

final class AppCoordinator: Coordinator {
    private let diContainer: AppDIContainer
    let navigationController: UINavigationController
    
    init(
        navigationController: UINavigationController,
        diContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }
    
    func start() {
        startHomeCoordinator()
    }
    
    private func startHomeCoordinator() {
        let homeDIContainer: HomeDIContainer = diContainer.resolve()
        let homeCoordinator = HomeCoordinator(
            navigationController: navigationController,
            diContainer: homeDIContainer
        )
        homeCoordinator.start()
    }
}
