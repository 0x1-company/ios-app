// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "BeMatch",
  defaultLocalization: "en",
  platforms: [
    .iOS("16.4"),
  ],
  products: [
    .library(name: "AnalyticsKeys", targets: ["AnalyticsKeys"]),
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "BannerFeature", targets: ["BannerFeature"]),
    .library(name: "BeMatch", targets: ["BeMatch"]),
    .library(name: "BeMatchClient", targets: ["BeMatchClient"]),
    .library(name: "BeRealCaptureFeature", targets: ["BeRealCaptureFeature"]),
    .library(name: "BeRealSampleFeature", targets: ["BeRealSampleFeature"]),
    .library(name: "Constants", targets: ["Constants"]),
    .library(name: "DeleteAccountFeature", targets: ["DeleteAccountFeature"]),
    .library(name: "DirectMessageFeature", targets: ["DirectMessageFeature"]),
    .library(name: "EditProfileFeature", targets: ["EditProfileFeature"]),
    .library(name: "ForceUpdateFeature", targets: ["ForceUpdateFeature"]),
    .library(name: "GenderSettingFeature", targets: ["GenderSettingFeature"]),
    .library(name: "LaunchFeature", targets: ["LaunchFeature"]),
    .library(name: "MaintenanceFeature", targets: ["MaintenanceFeature"]),
    .library(name: "MatchedFeature", targets: ["MatchedFeature"]),
    .library(name: "MatchEmptyFeature", targets: ["MatchEmptyFeature"]),
    .library(name: "MatchFeature", targets: ["MatchFeature"]),
    .library(name: "MatchNavigationFeature", targets: ["MatchNavigationFeature"]),
    .library(name: "NavigationFeature", targets: ["NavigationFeature"]),
    .library(name: "NotificationsReEnableFeature", targets: ["NotificationsReEnableFeature"]),
    .library(name: "OnboardFeature", targets: ["OnboardFeature"]),
    .library(name: "PremiumFeature", targets: ["PremiumFeature"]),
    .library(name: "ProfileExternalFeature", targets: ["ProfileExternalFeature"]),
    .library(name: "ProfileFeature", targets: ["ProfileFeature"]),
    .library(name: "ProfileSharedFeature", targets: ["ProfileSharedFeature"]),
    .library(name: "RecommendationEmptyFeature", targets: ["RecommendationEmptyFeature"]),
    .library(name: "RecommendationFeature", targets: ["RecommendationFeature"]),
    .library(name: "RecommendationLoadingFeature", targets: ["RecommendationLoadingFeature"]),
    .library(name: "RecommendationSwipeFeature", targets: ["RecommendationSwipeFeature"]),
    .library(name: "ReportFeature", targets: ["ReportFeature"]),
    .library(name: "SelectControl", targets: ["SelectControl"]),
    .library(name: "SettingsFeature", targets: ["SettingsFeature"]),
    .library(name: "Styleguide", targets: ["Styleguide"]),
    .library(name: "TutorialFeature", targets: ["TutorialFeature"]),
    .library(name: "UsernameSettingFeature", targets: ["UsernameSettingFeature"]),
  ],
  dependencies: [
    .package(path: "../SDK"),
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.7.1"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.1.5"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.6.0"),
    .package(url: "https://github.com/lorenzofiamingo/swiftui-cached-async-image", from: "2.1.1"),
  ],
  targets: [
    .target(name: "AnalyticsKeys", dependencies: [
      .product(name: "AnalyticsClient", package: "SDK"),
    ]),
    .target(name: "AppFeature", dependencies: [
      "LaunchFeature",
      "OnboardFeature",
      "NavigationFeature",
      "ForceUpdateFeature",
      "MaintenanceFeature",
      .product(name: "AsyncValue", package: "SDK"),
      .product(name: "AppsFlyerClient", package: "SDK"),
      .product(name: "ConfigGlobalClient", package: "SDK"),
      .product(name: "UserSettingsClient", package: "SDK"),
      .product(name: "FirebaseCoreClient", package: "SDK"),
      .product(name: "ApolloClientHelpers", package: "SDK"),
      .product(name: "FirebaseMessagingClient", package: "SDK"),
      .product(name: "ATTrackingManagerClient", package: "SDK"),
      .product(name: "NotificationCenterClient", package: "SDK"),
    ]),
    .target(name: "BannerFeature", dependencies: [
      "BeMatch",
      "Styleguide",
      "AnalyticsKeys",
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "BeMatch", dependencies: [
      .product(name: "ApolloAPI", package: "apollo-ios"),
    ]),
    .target(name: "BeMatchClient", dependencies: [
      "BeMatch",
      .product(name: "ApolloConcurrency", package: "SDK"),
      .product(name: "Dependencies", package: "swift-dependencies"),
      .product(name: "DependenciesMacros", package: "swift-dependencies"),
    ]),
    .target(name: "BeRealCaptureFeature", dependencies: [
      "Styleguide",
      "BeMatchClient",
      .product(name: "TcaHelpers", package: "SDK"),
      "AnalyticsKeys",
      .product(name: "FirebaseAuthClient", package: "SDK"),
      .product(name: "FirebaseStorageClient", package: "SDK"),
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "CachedAsyncImage", package: "swiftui-cached-async-image"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "BeRealSampleFeature", dependencies: [
      "Styleguide",
      "Constants",
      "AnalyticsKeys",
      .product(name: "UIApplicationClient", package: "SDK"),
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "Constants"),
    .target(name: "DeleteAccountFeature", dependencies: [
      "Styleguide",
      "BeMatchClient",
      "AnalyticsKeys",
      .product(name: "FirebaseAuthClient", package: "SDK"),
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "DirectMessageFeature", dependencies: [
      "AnalyticsKeys",
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "EditProfileFeature", dependencies: [
      "AnalyticsKeys",
      "BeMatch",
      "BeMatchClient",
      "BeRealCaptureFeature",
      "GenderSettingFeature",
      "UsernameSettingFeature",
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "ForceUpdateFeature", dependencies: [
      "Styleguide",
      "Constants",
      "AnalyticsKeys",
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "GenderSettingFeature", dependencies: [
      "Styleguide",
      "BeMatchClient",
      "AnalyticsKeys",
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "LaunchFeature", dependencies: [
      "Styleguide",
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "MaintenanceFeature", dependencies: [
      "Constants",
      "Styleguide",
      "AnalyticsKeys",
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "MatchedFeature", dependencies: [
      "Styleguide",
      "BeMatchClient",
      "AnalyticsKeys",
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "MatchEmptyFeature", dependencies: [
      "Styleguide",
      "AnalyticsKeys",
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "MatchFeature", dependencies: [
      "BannerFeature",
      "SettingsFeature",
      "MatchEmptyFeature",
      "ProfileExternalFeature",
      "NotificationsReEnableFeature",
      .product(name: "TcaHelpers", package: "SDK"),
      .product(name: "UserNotificationClient", package: "SDK"),
      .product(name: "CachedAsyncImage", package: "swiftui-cached-async-image"),
    ]),
    .target(name: "MatchNavigationFeature", dependencies: [
      "MatchFeature",
      "SettingsFeature",
    ]),
    .target(name: "NavigationFeature", dependencies: [
      "RecommendationFeature",
      "MatchNavigationFeature",
    ]),
    .target(name: "NotificationsReEnableFeature", dependencies: [
      .product(name: "UIApplicationClient", package: "SDK"),
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "OnboardFeature", dependencies: [
      "BeRealCaptureFeature",
      "BeRealSampleFeature",
      "GenderSettingFeature",
      "UsernameSettingFeature",
      .product(name: "PhotosClient", package: "SDK"),
      .product(name: "UserDefaultsClient", package: "SDK"),
      .product(name: "UIApplicationClient", package: "SDK"),
      .product(name: "FirebaseAuthClient", package: "SDK"),
      .product(name: "UserNotificationClient", package: "SDK"),
      .product(name: "FirebaseStorageClient", package: "SDK"),
    ]),
    .target(name: "PremiumFeature", dependencies: [
      "Styleguide",
      "AnalyticsKeys",
      .product(name: "ColorHex", package: "SDK"),
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "ProfileExternalFeature", dependencies: [
      "Constants",
      "Styleguide",
      "BeMatchClient",
      "SelectControl",
      "AnalyticsKeys",
      "ReportFeature",
      "DirectMessageFeature",
      .product(name: "CachedAsyncImage", package: "swiftui-cached-async-image"),
    ]),
    .target(name: "ProfileFeature", dependencies: [
      "ProfileSharedFeature",
    ]),
    .target(name: "ProfileSharedFeature", dependencies: [
      "Constants",
      "Styleguide",
      "BeMatchClient",
      "SelectControl",
      "AnalyticsKeys",
      "ReportFeature",
      "DirectMessageFeature",
      .product(name: "CachedAsyncImage", package: "swiftui-cached-async-image"),
    ]),
    .target(name: "RecommendationEmptyFeature", dependencies: [
      "Constants",
      "Styleguide",
      "BeMatchClient",
      "AnalyticsKeys",
      .product(name: "ActivityView", package: "SDK"),
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "RecommendationFeature", dependencies: [
      "MatchedFeature",
      "RecommendationEmptyFeature",
      "RecommendationSwipeFeature",
      "RecommendationLoadingFeature",
      .product(name: "UIApplicationClient", package: "SDK"),
      .product(name: "UserNotificationClient", package: "SDK"),
    ]),
    .target(name: "RecommendationLoadingFeature", dependencies: [
      "Styleguide",
      "AnalyticsKeys",
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "RecommendationSwipeFeature", dependencies: [
      "Styleguide",
      "BeMatchClient",
      "SelectControl",
      "ReportFeature",
      "AnalyticsKeys",
      .product(name: "TcaHelpers", package: "SDK"),
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "CachedAsyncImage", package: "swiftui-cached-async-image"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "ReportFeature", dependencies: [
      "Styleguide",
      "BeMatchClient",
      "AnalyticsKeys",
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "SelectControl"),
    .target(name: "SettingsFeature", dependencies: [
      "Constants",
      "AnalyticsKeys",
      "EditProfileFeature",
      "ProfileFeature",
      "TutorialFeature",
      "DeleteAccountFeature",
      .product(name: "Build", package: "SDK"),
      .product(name: "ActivityView", package: "SDK"),
      .product(name: "FirebaseAuthClient", package: "SDK"),
    ]),
    .target(name: "Styleguide"),
    .target(name: "TutorialFeature", dependencies: [
      "Styleguide",
      "AnalyticsKeys",
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "UsernameSettingFeature", dependencies: [
      "Styleguide",
      "BeMatchClient",
      "AnalyticsKeys",
      .product(name: "FeedbackGeneratorClient", package: "SDK"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
  ]
)
