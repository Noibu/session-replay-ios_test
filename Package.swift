// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NoibuSessionReplay",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "NoibuSessionReplay",
            targets: ["NoibuSessionReplay"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "NoibuSessionReplay",
            url: "https://github.com/Noibu/session-replay-ios_test/releases/download/0.8.0/NoibuSessionReplay.xcframework.zip",
            checksum: "a7c7e06eeda61a87ac2b6a4c87c3b43122a5ec23ffe9ba0061f1e16c96e48dcd"
        )
    ]
)













