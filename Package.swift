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
        .package(path: "/Users/vaida/Library/Mobile Documents/com~apple~CloudDocs/DataBase/Projects/Packages/deprecated/LaTeX"),
        .package(url: "https://github.com/Vaida12345/FinderItem.git", from: "1.2.5")
    ], targets: [
        .target(name: "Manim", dependencies: ["LaTeX", "FinderItem"]),
        .testTarget(name: "ManimTests", dependencies: ["Manim"]),
        .executableTarget(name: "Client", dependencies: ["Manim"])
    ], swiftLanguageModes: [.v5]
)
