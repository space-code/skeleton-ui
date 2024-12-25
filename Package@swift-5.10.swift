// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SkeletonUI",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v8),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "SkeletonUI", targets: ["SkeletonUI"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            .upToNextMajor(from: "1.12.0")
        ),
    ],
    targets: [
        .target(name: "SkeletonUI", dependencies: []),
        .testTarget(
            name: "SkeletonUITests",
            dependencies: [
                "SkeletonUI",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
    ]
)
