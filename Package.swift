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
            url: "https://github.com/Noibu/session-replay-ios_test/releases/download/0.7.0/NoibuSessionReplay.xcframework.zip",
            checksum: "bee76227b8981cb6029195e2d021d9791ad83895364eeccf1d00834853b1ae1f"
        )
    ]
)












