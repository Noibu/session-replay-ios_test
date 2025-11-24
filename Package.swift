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
            checksum: "2e23ba9f54b878fd24d347e970f63530209dcfc8451f1f07db61312480e23ec3"
        )
    ]
)



