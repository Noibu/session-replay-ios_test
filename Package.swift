// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NoibuSessionReplay",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "NoibuSessionReplay",
            targets: ["NoibuSessionReplay"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "NoibuSessionReplay",
            url: "https://github.com/user-attachments/files/23731012/NoibuSessionReplay.xcframework.zip",
            checksum: "b5c9e3e2624c7289f6a8b53c5a13a79442af4626f9a786502dbb8df18a9d0770"
        )
    ]
)
