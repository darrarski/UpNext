// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "Common",
  platforms: [
    .iOS(.v14),
    .macOS(.v11)
  ],
  products: [
    .library(
      name: "Common",
      targets: ["Common"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture.git",
      from: "0.13.0"
    ),
    .package(path: "../Testing")
  ],
  targets: [
    .target(
      name: "Common",
      dependencies: [
        .product(
          name: "ComposableArchitecture",
          package: "swift-composable-architecture"
        )
      ],
      path: "Sources"
    ),
    .testTarget(
      name: "CommonTests",
      dependencies: [
        "Common",
        "Testing"
      ],
      path: "Tests"
    )
  ]
)
