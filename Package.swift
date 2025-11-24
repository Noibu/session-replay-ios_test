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
            url: "https://github.com/Noibu/session-replay-ios_test/releases/download/0.4.0/NoibuSessionReplayFat.xcframework.zip",
            checksum: "175a75d154b8fc8cfe6772c7169b4c99b9c40164200f0b880485fb0d1167774a"
        )
    ]
)








