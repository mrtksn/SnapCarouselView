// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SnapCarouselView",
    platforms: [
        .macOS(.v11), // Minimum macOS version 10.15
        .iOS(.v15)       // Minimum iOS version 15.0
    ],
    products: [
        .library(
            name: "SnapCarouselView",
            targets: ["SnapCarouselView"]),
    ],
    targets: [
        .target(
            name: "SnapCarouselView"),
        .testTarget(
            name: "SnapCarouselViewTests",
            dependencies: ["SnapCarouselView"]),
    ]
)
