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
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50100.0")),
        .package(url: "https://github.com/vapor/websocket.git", from: "1.0.0"),
        // .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "1.0.0"),
        // .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "CDDSwift",
            dependencies: ["WebSocket", "SwiftSyntax"]),
        .testTarget(
            name: "CDDSwiftTests",
            dependencies: ["CDDSwift"]),
    ]
)
