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
            url: "https://github.com/Noibu/session-replay-ios/releases/download/0.1.0/NoibuSessionReplay.xcframework.zip",
            checksum: "1fc36b66909442ddcfb69ea3a3edd989997c745e221912bce9eb2853f48e4d26"
        )
    ]
)


















