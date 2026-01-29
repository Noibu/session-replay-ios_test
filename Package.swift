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
            checksum: "82f796273f748389eb60ef3f6e32bc5684fe39d9610ed797396ea9241f69db89"
        )
    ]
)

















