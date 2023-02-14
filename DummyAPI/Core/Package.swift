// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CoreModels",
            targets: ["CoreModels"]
        ),
        .library(
            name: "CoreServices",
            targets: ["CoreServices"]
        ),
        .library(
            name: "CoreUseCases",
            targets: ["CoreUseCases"]
        )
    ],
    dependencies: [
        .package(path: "../Utils"),
        .package(path: "../Networking"),
        .package(path: "../Config"),
    ],
    targets: [
        .target(
            name: "CoreModels",
            dependencies: [
                "Config"
            ]
        ),
        .target(
            name: "CoreServices",
            dependencies: [
                "Utils",
                "CoreModels",
                "Networking"
            ]
        ),
        .target(
            name: "CoreUseCases",
            dependencies: [
                "Utils",
                "Networking",
                "CoreModels",
                "CoreServices"
            ]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: [
                "CoreModels",
                "CoreServices",
                "CoreUseCases"
            ]),
    ]
)
