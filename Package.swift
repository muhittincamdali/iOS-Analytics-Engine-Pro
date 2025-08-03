// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnalyticsEnginePro",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "AnalyticsEnginePro",
            targets: ["AnalyticsEnginePro"]
        ),
        .library(
            name: "AnalyticsCore",
            targets: ["AnalyticsCore"]
        ),
        .library(
            name: "RealTimeTracking",
            targets: ["RealTimeTracking"]
        ),
        .library(
            name: "PredictiveAnalytics",
            targets: ["PredictiveAnalytics"]
        ),
        .library(
            name: "ABTesting",
            targets: ["ABTesting"]
        ),
        .library(
            name: "UserBehavior",
            targets: ["UserBehavior"]
        ),
        .library(
            name: "DataVisualization",
            targets: ["DataVisualization"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-metrics.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio-http2.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-nio-extras.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-nio-ssl.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio-transport-services.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "AnalyticsEnginePro",
            dependencies: [
                "AnalyticsCore",
                "RealTimeTracking",
                "PredictiveAnalytics",
                "ABTesting",
                "UserBehavior",
                "DataVisualization",
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Metrics", package: "swift-metrics"),
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "NIOHTTP2", package: "swift-nio-http2"),
                .product(name: "NIOExtras", package: "swift-nio-extras"),
                .product(name: "NIOSSL", package: "swift-nio-ssl"),
                .product(name: "NIOTransportServices", package: "swift-nio-transport-services")
            ],
            path: "Sources/AnalyticsEnginePro"
        ),
        .target(
            name: "AnalyticsCore",
            dependencies: [
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Metrics", package: "swift-metrics")
            ],
            path: "Sources/AnalyticsCore"
        ),
        .target(
            name: "RealTimeTracking",
            dependencies: [
                "AnalyticsCore",
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "NIOHTTP2", package: "swift-nio-http2"),
                .product(name: "NIOExtras", package: "swift-nio-extras"),
                .product(name: "NIOSSL", package: "swift-nio-ssl"),
                .product(name: "NIOTransportServices", package: "swift-nio-transport-services")
            ],
            path: "Sources/RealTimeTracking"
        ),
        .target(
            name: "PredictiveAnalytics",
            dependencies: [
                "AnalyticsCore",
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Crypto", package: "swift-crypto")
            ],
            path: "Sources/PredictiveAnalytics"
        ),
        .target(
            name: "ABTesting",
            dependencies: [
                "AnalyticsCore",
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Crypto", package: "swift-crypto")
            ],
            path: "Sources/ABTesting"
        ),
        .target(
            name: "UserBehavior",
            dependencies: [
                "AnalyticsCore",
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Crypto", package: "swift-crypto")
            ],
            path: "Sources/UserBehavior"
        ),
        .target(
            name: "DataVisualization",
            dependencies: [
                "AnalyticsCore",
                .product(name: "Collections", package: "swift-collections")
            ],
            path: "Sources/DataVisualization"
        ),
        .testTarget(
            name: "AnalyticsEngineProTests",
            dependencies: [
                "AnalyticsEnginePro",
                "AnalyticsCore",
                "RealTimeTracking",
                "PredictiveAnalytics",
                "ABTesting",
                "UserBehavior",
                "DataVisualization"
            ],
            path: "Tests/UnitTests"
        ),
        .testTarget(
            name: "AnalyticsEngineProIntegrationTests",
            dependencies: [
                "AnalyticsEnginePro",
                "AnalyticsCore",
                "RealTimeTracking",
                "PredictiveAnalytics",
                "ABTesting",
                "UserBehavior",
                "DataVisualization"
            ],
            path: "Tests/IntegrationTests"
        ),
        .testTarget(
            name: "AnalyticsEngineProPerformanceTests",
            dependencies: [
                "AnalyticsEnginePro",
                "AnalyticsCore",
                "RealTimeTracking",
                "PredictiveAnalytics",
                "ABTesting",
                "UserBehavior",
                "DataVisualization"
            ],
            path: "Tests/PerformanceTests"
        )
    ]
) 