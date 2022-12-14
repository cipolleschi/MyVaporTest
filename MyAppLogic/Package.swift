// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "MyAppLogic",
    platforms: [
      .macOS(.v12), .iOS(.v15)
    ],
    products: [
      .library(name: "Server", targets: ["Server"]),
      .library(name: "Client", targets: ["Client"])
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "Server",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .target(name: "Logic")
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .target(name: "Logic"),
        .target(name: "Client", dependencies: [ .target(name: "Logic")]),
        .testTarget(name: "ServerTests", dependencies: [
            .target(name: "Server"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
