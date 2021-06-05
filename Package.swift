// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "R2LCPClient",
    defaultLocalization: "en",
    platforms: [.iOS(.v10), .macOS("10.12"), .tvOS(.v9)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "R2LCPClient",
            targets: ["R2LCPClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", .exact("0.12.2")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .exact("1.3.8")),
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", .exact("0.9.11")),
        .package(name: "R2Shared", url: "https://github.com/stevenzeck/r2-shared-swift.git", .branch("use-spm"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "R2LCPClient",
            dependencies: [.product(name: "SQLite", package: "SQLite.swift"), "CryptoSwift", "ZIPFoundation", "R2Shared"],
            path: "./readium-lcp-swift/",
            exclude: ["Info.plist"],
            resources: [
                .copy("Resources")
            ]
        ),
        .testTarget(
            name: "r2-lcp-swiftTests",
            dependencies: ["R2LCPClient"],
            path: "./readium-lcp-swiftTests/",
            exclude: ["Info.plist"],
            resources: [
                .copy("Fixtures")
            ]
        )
    ]
)
