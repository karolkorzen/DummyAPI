//
//  HomeCoordinator.swift
//  
//
//  Created by Karol Korzeń on 14/02/2023.
//

import Foundation
import Coordinator
import SwiftUI

public final class HomeCoordinator: Coordinator {
    private let diContainer: HomeDIContainer
    public let navigationController: UINavigationController
    
    public init(
        navigationController: UINavigationController,
        diContainer: HomeDIContainer
    ) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }
    
    public func start() {
        pushMainScene()
    }
    
    private func pushMainScene() {
        let viewModel: DefaultMainSceneViewModel = diContainer.resolve()
        let sceneView = MainSceneSceneView(interactor: viewModel)
        let hostingController = UIHostingController(rootView: sceneView)
        navigationController.pushViewController(hostingController, animated: true)
    }
}
