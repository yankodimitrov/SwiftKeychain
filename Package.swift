// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "SwiftKeychain",
    products: [
        .library(
            name: "SwiftKeychain",
            targets: ["SwiftKeychain"]),
        .library(
            name: "SwiftKeychain watchOS",
            targets: ["SwiftKeychain"]),
        .library(
            name: "SwiftKeychain tvOS",
            targets: ["SwiftKeychain"]),
        .library(
            name: "SwiftKeychain OSX",
            targets: ["SwiftKeychain"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftKeychain",
            dependencies: [],
            path: ".",
            sources: ["Keychain"]),
    ]
)
