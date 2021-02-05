// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "Testing",
  platforms: [
    .iOS(.v14),
    .macOS(.v11)
  ],
  products: [
    .library(
      name: "Testing",
      targets: ["Testing"]
    )
  ],
  dependencies: [
    .package(
      name: "Quick",
      url: "https://github.com/Quick/Quick.git",
      from: "3.0.0"
    ),
    .package(
      name: "Nimble",
      url: "https://github.com/Quick/Nimble.git", 
      from: "9.0.0"
    ),
    .package(
      name: "SnapshotTesting",
      url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
      from: "1.8.2"
    )
  ],
  targets: [
    .target(
      name: "Testing",
      dependencies: [
        "Quick",
        "Nimble",
        "SnapshotTesting",
      ],
      path: "Sources"
    )
  ]
)
