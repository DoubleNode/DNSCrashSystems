// swift-tools-version:5.7
//
//  Package.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCrashSystems
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "DNSCrashSystems",
    platforms: [
        .iOS(.v16),
        .tvOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "DNSCrashSystems",
            type: .static,
            targets: ["DNSCrashSystems"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/DoubleNode/DNSBlankSystems.git", from: "1.11.0"),
        .package(url: "https://github.com/DoubleNode/DNSError.git", from: "1.11.0"),
        .package(url: "https://github.com/DoubleNode/DNSProtocols.git", from: "1.11.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "DNSCrashSystems",
            dependencies: ["DNSBlankSystems", "DNSError", "DNSProtocols"]),
        .testTarget(
            name: "DNSCrashSystemsTests",
            dependencies: ["DNSCrashSystems"]),
    ],
    swiftLanguageVersions: [.v5]
)
