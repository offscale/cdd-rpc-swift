// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CDDSwift",
	// platforms: [
	// 	.macOS(.v10_13)
	// ],
    products: [
        .executable(name: "cdd-swift", targets: ["CDDSwift"]),
    ],
    // name: "cdd-rpc-swift",
    // products: [
    //     // Products define the executables and libraries produced by a package, and make them visible to other packages.
    //     // .library(
    //     //     name: "cdd-rpc-swift",
    //     //     targets: ["cdd-rpc-swift"]),
    //     .executable(name: "cdd-rpc-swift-cli", targets: ["cdd-rpc-swift"]),
    // ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50000.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CDDSwift",
            dependencies: ["SwiftSyntax"]),
        .testTarget(
            name: "CDDSwiftTests",
            dependencies: ["CDDSwift"]),
    ]
)
