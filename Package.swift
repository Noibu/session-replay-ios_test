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
            url: "https://github.com/Noibu/session-replay-ios_test/releases/download/0.6.0/NoibuSessionReplay.xcframework.zip",
            checksum: "a8d0db2e89cabda5fde7be8a49ec61c0fa4ab93eb9022f0eab876792efa35f4c"
        )
    ]
)











