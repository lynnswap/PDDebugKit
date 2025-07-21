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
            url: "https://github.com/Shakshi3104/DeviceHardware.git",
            from: "3.4.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PDDebugKit",
            dependencies: [
                .product(name: "DeviceHardware", package: "DeviceHardware")
            ]
        ),
        .testTarget(
            name: "PDDebugKitTests",
            dependencies: ["PDDebugKit"]
        ),
    ]
)
