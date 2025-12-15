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
            url: "https://github.com/Noibu/session-replay-ios_test/releases/download/0.9.0/NoibuSessionReplay.xcframework.zip",
            checksum: "f0552ffc9c1f0ced9edef24b5d1f34a0940d903bf984f892d54b27da255074ff"
        )
    ]
)















