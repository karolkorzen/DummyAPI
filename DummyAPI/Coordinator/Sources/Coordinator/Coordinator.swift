//
//  File.swift
//  
//
//  Created by Karol Korzeń on 15/02/2023.
//

import Foundation
import UIKit

public protocol Coordinator {
    //TODO: - Routing
    //TODO: - Global AppCoordinator
    
    var navigationController: UINavigationController { get }

    func start()
}
