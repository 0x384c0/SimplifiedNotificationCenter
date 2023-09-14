// swift-tools-version:5.8
//
//  Package.swift
//  SimplifiedNotificationCenter
//
//  Created by 0x384c0 on 04.08.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "SimplifiedNotificationCenter",
    platforms: [.macOS(.v10_13),
                .iOS(.v11),
                .tvOS(.v11),
                .watchOS(.v4)],
    products: [
        .library(
            name: "SimplifiedNotificationCenter",
            targets: ["SimplifiedNotificationCenter"]),
    ],
    targets: [
        .target(
            name: "SimplifiedNotificationCenter",
            path: "SimplifiedNotificationCenter/Classes"
            ),
        .testTarget(
            name: "SimplifiedNotificationCenterTests",
            dependencies: ["SimplifiedNotificationCenter"],
            path: "SimplifiedNotificationCenter/Tests",
            exclude: ["Info.plist"]
            )
    ],
    swiftLanguageVersions: [.v5]
)
