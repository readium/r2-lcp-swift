// swift-tools-version:5.3
//
//  Copyright 2021 Readium Foundation. All rights reserved.
//  Use of this source code is governed by the BSD-style license
//  available in the top-level LICENSE file of the project.
//

import PackageDescription

let package = Package(
    name: "r2-lcp-swift",
    defaultLocalization: "en",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "R2LCPClient",
            targets: ["R2LCPClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.12.2"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.3.8"),
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", .exact("0.9.11")),
        .package(url: "https://github.com/readium/r2-shared-swift.git", .branch("develop")),
    ],
    targets: [
        .target(
            name: "R2LCPClient",
            dependencies: [
                .product(name: "SQLite", package: "SQLite.swift"),
                .product(name: "R2Shared", package: "r2-shared-swift"),
                "CryptoSwift",
                "ZIPFoundation",
            ],
            path: "./readium-lcp-swift/",
            exclude: ["Info.plist"],
            resources: [
                .copy("Resources")
            ]
        ),
        .testTarget(
            name: "R2LCPTests",
            dependencies: ["R2LCPClient"],
            path: "./readium-lcp-swiftTests/",
            exclude: ["Info.plist"],
            resources: [
                .copy("Fixtures")
            ]
        )
    ]
)
