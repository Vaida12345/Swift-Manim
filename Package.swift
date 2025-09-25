// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Manim",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "Manim", targets: ["Manim"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Vaida12345/FinderItem.git", from: "1.2.5"),
        .package(url: "https://github.com/pvieito/PythonKit.git", branch: "master")
    ],
    targets: [
        .target(
            name: "Manim",
            dependencies: [
                "FinderItem",
                "PythonKit"
            ]
        ),
        .executableTarget(name: "Client", dependencies: ["Manim"])
    ]
)
