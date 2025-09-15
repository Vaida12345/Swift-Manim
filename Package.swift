// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Manim",
    platforms: [
        .macOS(.v14)
    ], products: [
        .library(name: "Manim", targets: ["Manim"]),
    ], dependencies: [
        .package(url: "https://github.com/Vaida12345/Swift-LaTeX.git", branch: "main"),
        .package(url: "https://github.com/Vaida12345/FinderItem.git", from: "1.2.5"),
        .package(url: "https://github.com/Vaida12345/MacroCollection.git", from: "1.0.5"),
    ], targets: [
        .target(name: "Manim", dependencies: [.product(name: "LaTeX", package: "Swift-Latex"), "FinderItem", "MacroCollection"]),
        .testTarget(name: "ManimTests", dependencies: ["Manim"]),
        .executableTarget(name: "Client", dependencies: ["Manim"])
    ], swiftLanguageModes: [.v5]
)
