// swift-tools-version:5.3
//
//  Copyright 2021 Readium Foundation. All rights reserved.
//  Use of this source code is governed by the BSD-style license
//  available in the top-level LICENSE file of the project.
//

import PackageDescription

let package = Package(
    name: "R2LCPClient",
    defaultLocalization: "en",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "R2LCPClient",
            targets: ["R2LCPClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", .exact("0.12.2")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .exact("1.3.8")),
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", .exact("0.9.11")),
        .package(name: "R2Shared", url: "https://github.com/readium/r2-shared-swift.git", .branch("develop")),
    ],
    targets: [
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
