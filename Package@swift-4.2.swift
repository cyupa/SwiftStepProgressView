// swift-tools-version:4.2
//
//  SwiftStepProgressView.swift
//  SwiftStepProgressView
//
//  Created by Ciprian Redinciuc on 01/04/19.
//  Copyright © 2019 cyupa. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "SwiftStepProgressView",
    products: [
        .library(
            name: "SwiftStepProgressView",
            targets: ["SwiftStepProgressView"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftStepProgressView",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "SwiftStepProgressViewTests",
            dependencies: ["SwiftStepProgressView"],
            path: "Tests"
        ),
    ],
    swiftLanguageVersions: [.v4, .v4_2]
)
