// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SkeletonUI",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v8),
    ],
    products: [
        .library(name: "SkeletonUI", targets: ["SkeletonUI"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SkeletonUI", dependencies: []),
        .testTarget(name: "SkeletonUITests", dependencies: ["SkeletonUI"]),
    ]
)