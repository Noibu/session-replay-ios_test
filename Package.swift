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
            url: "https://github.com/Noibu/session-replay-ios_test/releases/download/0.2.0/NoibuSessionReplayFat.xcframework.zip",
            checksum: "10a25659a11c6ded5eb605f11f1d20fb3264acce5fa762eccbcb5302a3c348c6"
        )
    ]
)






