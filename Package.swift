// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mustache-analytics",
    platforms: [
        .macOS(.v14)
    ],
    dependencies: [
      .package(url: "https://github.com/hummingbird-project/swift-mustache.git", from: "2.0.0"),
      .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.5.0"),
      .package(url: "https://github.com/MarkCodable/MarkCodable.git", from: "0.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "AnalyticsGenerator",
            dependencies: [
                .product(name: "Mustache", package: "swift-mustache"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "MarkCodable", package: "MarkCodable")
            ]
        ),
    ]
)
