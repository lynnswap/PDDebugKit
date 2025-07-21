// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PDDebugKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PDDebugKit",
            targets: ["PDDebugKit"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/devicekit/DeviceKit.git",
            from: "5.5.0"
        ),
        .package(url: "https://github.com/kyome22/DeviceModel.git",
           from: "1.0.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PDDebugKit",
            dependencies: [
                .product(name: "DeviceKit", package: "DeviceKit",condition: .when(platforms: [.iOS])),
                .product(name: "DeviceModel",package: "DeviceModel",condition: .when(platforms: [.macOS]))
            ]
        ),
        .testTarget(
            name: "PDDebugKitTests",
            dependencies: ["PDDebugKit"]
        ),
    ]
)
