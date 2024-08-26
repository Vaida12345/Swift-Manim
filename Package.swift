// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Manim",
    platforms: [
        .macOS(.v14)
    ], products: [
        .library(name: "Manim", targets: ["Manim"]),
    ], dependencies: [
        .package(path: "/Users/vaida/Library/Mobile Documents/com~apple~CloudDocs/DataBase/Projects/Packages/deprecated/LaTeX")
    ], targets: [
        .target(name: "Manim", dependencies: ["LaTeX"]),
        .testTarget(name: "ManimTests", dependencies: ["Manim"]),
        .executableTarget(name: "Client", dependencies: ["Manim"])
    ]
)
