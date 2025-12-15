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
            checksum: "1aa48e4d90bcfca2ecc48984a0e9a6b834be4423ff63c10d919ad047a1affee6"
        )
    ]
)














