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
            url: "https://github.com/Noibu/session-replay-ios_test/releases/download/0.5.0/NoibuSessionReplay.xcframework.zip",
            checksum: "2c0c8664c6d501e03d7385b26bd05c1af43f5cce5257c035690aa949ad1d34f6"
        )
    ]
)









