// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HomeFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "HomeFeature",
            targets: ["HomeFeature"]),
    ],
    dependencies: [
        .package(path: "../Utils"),
        .package(path: "../CommonUI"),
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "HomeFeature",
            dependencies: [
                .product(name: "CommonResources", package: "CommonUI"),
                .product(name: "CommonUIUtils", package: "CommonUI"),
                .product(name: "CoreModels", package: "Core"),
                .product(name: "CoreServices", package: "Core"),
                .product(name: "CoreUseCases", package: "Core")
            ]
        ),
        .testTarget(
            name: "HomeFeatureTests",
            dependencies: ["HomeFeature"]),
    ]
)
