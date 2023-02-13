//
//  SceneDelegate.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var diContainer = DefaultAppDIContainer()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let diContainer: HomeDIContainer = diContainer.resolve()
        let interactor = diContainer.resolve()
        let sceneView = MainSceneSceneView(interactor: interactor)
        let controller = UIHostingController(rootView: sceneView)
        
        window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

