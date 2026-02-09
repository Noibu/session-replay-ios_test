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
            checksum: "dad0059525eeee8a0e13884ea32159b4547d150401419f054edaec7158788dd7"
        )
    ]
)



















