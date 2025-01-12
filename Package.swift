// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "StoreReviews",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "StoreReviews", targets: ["StoreReviews"]),
    ],
    targets: [
        .target(name: "StoreReviews"),
    ]
)
