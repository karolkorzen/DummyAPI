//
//  SceneView.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 13/02/2023.
//

import SwiftUI

/// A view that represents single page in the navigation stack (similar to a UIViewController)
public protocol SceneView: View {
    associatedtype Interactor: ObservableObject
}
