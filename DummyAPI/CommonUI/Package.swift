// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonUI",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CommonResources",
            targets: ["CommonResources"]
        ),
        .library(
            name: "CommonUIUtils",
            targets: ["CommonUIUtils"]
        )
    ],
    dependencies: [
        .package(path: "../Utils")
    ],
    targets: [
        .target(
            name: "CommonResources",
            dependencies: [
                "Utils"
            ]
        ),
        .target(
            name: "CommonUIUtils",
            dependencies: [
                "Utils"
            ]
        )
    ]
)
