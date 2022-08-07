// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "MyFirstServer",
    platforms: [
       .macOS(.v12)
    ],
    dependencies: [
        .package(name: "MyAppLogic", path: "../MyAppLogic/")
    ],
    targets: [
      .executableTarget(name: "Run", dependencies: [
        .product(name: "Server", package: "MyAppLogic")
      ]),
    ]
)
