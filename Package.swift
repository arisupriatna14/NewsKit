// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "NewsKit",
  platforms: [.iOS(.v15), .macOS(.v10_15)],
  products: [
    .library(
      name: "NewsKit",
      targets: ["NewsKit"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0"))
  ],
  targets: [
    .target(
      name: "NewsKit",
      dependencies: [
        "Alamofire",
      ]
    ),
    .testTarget(
      name: "NewsKitTests",
      dependencies: ["NewsKit"]
    ),
  ]
)
