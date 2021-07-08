// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Playground",
    products: [
        .executable(name: "Playground", targets: ["Playground"]),
    ],
    targets: [
        .target(
            name: "Playground",
            dependencies: ["SwiftInternal"],
            swiftSettings: [
                .unsafeFlags(["-Xfrontend", "-enable-experimental-concurrency"]),
            ]),
        .target(
            name: "SwiftInternal",
            linkerSettings: [
                .linkedLibrary("swift_Concurrency"),
                .unsafeFlags(["-L/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2020-12-22-a.xctoolchain/usr/lib/swift/macosx/"]),
            ]),
        .testTarget(
            name: "PlaygroundTests",
            dependencies: ["Playground"]),
    ],
    cxxLanguageStandard: .cxx14
)
