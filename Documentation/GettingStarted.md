# Getting Started Guide

<!-- TOC START -->
## Table of Contents
- [Getting Started Guide](#getting-started-guide)
- [Overview](#overview)
- [Prerequisites](#prerequisites)
  - [System Requirements](#system-requirements)
  - [Development Environment](#development-environment)
- [Installation](#installation)
  - [Swift Package Manager](#swift-package-manager)
  - [Manual Installation](#manual-installation)
- [Clone the repository](#clone-the-repository)
- [Navigate to project directory](#navigate-to-project-directory)
- [Install dependencies](#install-dependencies)
- [Open in Xcode](#open-in-xcode)
- [Basic Setup](#basic-setup)
  - [1. Import the Framework](#1-import-the-framework)
  - [2. Initialize Analytics Engine](#2-initialize-analytics-engine)
  - [3. Basic Event Tracking](#3-basic-event-tracking)
- [Configuration](#configuration)
  - [Basic Configuration](#basic-configuration)
  - [Environment-Specific Configuration](#environment-specific-configuration)
- [Event Tracking](#event-tracking)
  - [Automatic Events](#automatic-events)
  - [Custom Events](#custom-events)
  - [User Properties](#user-properties)
- [Privacy Compliance](#privacy-compliance)
  - [GDPR Setup](#gdpr-setup)
  - [User Consent](#user-consent)
- [A/B Testing](#ab-testing)
  - [Basic A/B Test](#basic-ab-test)
  - [User Assignment](#user-assignment)
- [Machine Learning](#machine-learning)
  - [User Segmentation](#user-segmentation)
  - [Predictive Analytics](#predictive-analytics)
- [Performance Monitoring](#performance-monitoring)
  - [App Performance](#app-performance)
  - [Memory Monitoring](#memory-monitoring)
- [Data Export](#data-export)
  - [Export User Data](#export-user-data)
  - [Data Deletion](#data-deletion)
- [Best Practices](#best-practices)
  - [1. Initialize Early](#1-initialize-early)
  - [2. Use Meaningful Event Names](#2-use-meaningful-event-names)
  - [3. Include Relevant Properties](#3-include-relevant-properties)
  - [4. Test Thoroughly](#4-test-thoroughly)
  - [5. Monitor Performance](#5-monitor-performance)
- [Troubleshooting](#troubleshooting)
  - [Common Issues](#common-issues)
  - [Debug Mode](#debug-mode)
  - [Error Handling](#error-handling)
- [Next Steps](#next-steps)
- [Support](#support)
<!-- TOC END -->


## Overview

This guide will help you get started with iOS Analytics Engine Pro quickly and efficiently. Follow these steps to integrate analytics into your iOS application.

## Prerequisites

### System Requirements

- **macOS**: 12.0+ (Monterey or later)
- **iOS**: 15.0+ (Minimum deployment target)
- **Xcode**: 15.0+ (Latest stable version)
- **Swift**: 5.9+ (Latest Swift version)
- **Git**: For version control
- **Swift Package Manager**: For dependency management

### Development Environment

1. **Install Xcode** from the Mac App Store
2. **Update to latest version** for best compatibility
3. **Install Git** if not already installed
4. **Set up iOS Simulator** for testing

## Installation

### Swift Package Manager

1. **Open your Xcode project**
2. **Add package dependency**:
   - Go to File → Add Package Dependencies
   - Enter URL: `https://github.com/muhittincamdali/iOS-Analytics-Engine-Pro.git`
   - Click "Add Package"

3. **Select target** and click "Add Package"

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/muhittincamdali/iOS-Analytics-Engine-Pro.git

# Navigate to project directory
cd iOS-Analytics-Engine-Pro

# Install dependencies
swift package resolve

# Open in Xcode
open Package.swift
```

## Basic Setup

### 1. Import the Framework

```swift
import AnalyticsEnginePro
```

### 2. Initialize Analytics Engine

```swift
// Create analytics engine instance
let analyticsEngine = AnalyticsEngine.shared

// Create configuration
let config = AnalyticsConfiguration()
config.enableAutomaticTracking = true
config.enableRealTimeAnalytics = true
config.enablePrivacyCompliance = true

// Start analytics engine
analyticsEngine.start(with: config)
```

### 3. Basic Event Tracking

```swift
// Track simple events
analyticsEngine.trackEvent("app_launched")
analyticsEngine.trackEvent("button_clicked")

// Track events with properties
analyticsEngine.trackEvent("purchase_completed", properties: [
    "product_id": "premium_subscription",
    "price": 9.99,
    "currency": "USD"
])
```

## Configuration

### Basic Configuration

```swift
// Configure analytics settings
let config = AnalyticsConfiguration()

// Enable features
config.enableAutomaticTracking = true
config.enableRealTimeAnalytics = true
config.enablePrivacyCompliance = true
config.enableABTesting = false
config.enableMachineLearning = false

// Privacy settings
config.gdprCompliance = true
config.dataRetentionDays = 365
config.anonymizeUserData = false

// Performance settings
config.batchSize = 100
config.flushInterval = 30
config.maxQueueSize = 1000

// Apply configuration
analyticsEngine.configure(config)
```

### Environment-Specific Configuration

```swift
// Development configuration
let devConfig = AnalyticsConfiguration()
devConfig.environment = .development
devConfig.logLevel = .debug
devConfig.enableRealTimeAnalytics = false
devConfig.apiEndpoint = "https://dev-api.analytics.com"

// Production configuration
let prodConfig = AnalyticsConfiguration()
prodConfig.environment = .production
prodConfig.logLevel = .info
prodConfig.enableRealTimeAnalytics = true
prodConfig.apiEndpoint = "https://api.analytics.com"
```

## Event Tracking

### Automatic Events

```swift
// Enable automatic event tracking
let autoTracking = AutomaticEventTracking()
autoTracking.enableScreenTracking = true
autoTracking.enableAppLifecycleTracking = true
autoTracking.enableGestureTracking = true
autoTracking.enableNetworkTracking = true

// Start automatic tracking
autoTracking.startTracking()
```

### Custom Events

```swift
// Track custom events
analyticsEngine.trackEvent("feature_used", properties: [
    "feature_name": "search",
    "search_query": "analytics",
    "results_count": 15
])

analyticsEngine.trackEvent("button_clicked", properties: [
    "button_id": "subscribe_button",
    "button_location": "home_screen"
])

analyticsEngine.trackEvent("content_viewed", properties: [
    "content_type": "article",
    "content_id": "12345",
    "view_duration": 120
])
```

### User Properties

```swift
// Set user properties
analyticsEngine.setUserProperty("subscription_type", value: "premium")
analyticsEngine.setUserProperty("user_segment", value: "high_value")
analyticsEngine.setUserProperty("app_version", value: "1.2.3")

// Set user ID
analyticsEngine.setUserID("user_12345")
```

## Privacy Compliance

### GDPR Setup

```swift
// Configure GDPR compliance
let privacyConfig = PrivacyConfiguration()
privacyConfig.gdprCompliance = true
privacyConfig.dataRetentionDays = 365
privacyConfig.anonymizeUserData = true
privacyConfig.requireConsent = true

// Apply privacy configuration
analyticsEngine.configurePrivacy(privacyConfig)
```

### User Consent

```swift
// Request user consent
let consentManager = UserConsentManager()
consentManager.requestConsent(forUser: "user_123") { result in
    switch result {
    case .granted(let permissions):
        print("User granted permissions: \(permissions)")
        analyticsEngine.enableTracking()
        
    case .denied:
        print("User denied tracking")
        analyticsEngine.disableTracking()
        
    case .partial(let permissions):
        print("User granted partial permissions: \(permissions)")
        analyticsEngine.enablePartialTracking(permissions)
    }
}
```

## A/B Testing

### Basic A/B Test

```swift
// Create A/B test experiment
let experiment = ABTestExperiment(
    id: "button_color_test",
    name: "Button Color Optimization",
    description: "Test different button colors for conversion optimization"
)

// Define variations
let variations = [
    ExperimentVariation(
        id: "control",
        name: "Control (Blue)",
        properties: ["button_color": "blue"]
    ),
    ExperimentVariation(
        id: "green",
        name: "Green Button",
        properties: ["button_color": "green"]
    )
]

experiment.variations = variations
experiment.trafficAllocation = 0.1 // 10% of users
experiment.primaryMetric = "conversion_rate"

// Start experiment
let abTestManager = ABTestManager()
abTestManager.startExperiment(experiment)
```

### User Assignment

```swift
// Assign user to experiment variation
let userAssignment = abTestManager.assignUserToVariation(
    userId: "user_123",
    experimentId: "button_color_test"
)

if let variation = userAssignment {
    print("User assigned to variation: \(variation.id)")
    
    // Apply variation to UI
    applyButtonColor(variation.properties["button_color"] as? String ?? "blue")
}
```

## Machine Learning

### User Segmentation

```swift
// Create user segmentation model
let userSegmentation = UserSegmentationModel()

// Train segmentation model
userSegmentation.trainModel(withData: historicalUserData) { model in
    print("User segmentation model trained successfully")
}

// Segment users
let userSegments = userSegmentation.segmentUsers(currentUsers: activeUsers)
for segment in userSegments {
    print("Segment: \(segment.name)")
    print("User count: \(segment.userCount)")
}
```

### Predictive Analytics

```swift
// Create predictive analytics model
let predictiveModel = PredictiveAnalyticsModel()

// Train churn prediction model
predictiveModel.trainChurnModel(withData: userBehaviorData) { model in
    print("Churn prediction model trained successfully")
}

// Predict user churn
let churnPredictions = predictiveModel.predictChurn(forUsers: activeUsers)
for prediction in churnPredictions {
    print("User: \(prediction.userId)")
    print("Churn probability: \(prediction.churnProbability)%")
}
```

## Performance Monitoring

### App Performance

```swift
// Initialize performance analytics
let performanceAnalytics = PerformanceAnalytics()

// Track app performance
performanceAnalytics.trackAppLaunch(duration: 2.5)
performanceAnalytics.trackScreenLoad(screen: "HomeView", duration: 1.2)
performanceAnalytics.trackAPICall(endpoint: "/api/users", duration: 0.8)

// Get performance insights
let performanceInsights = performanceAnalytics.getPerformanceInsights()
print("App launch time: \(performanceInsights.averageLaunchTime)s")
print("Crash rate: \(performanceInsights.crashRate)%")
```

### Memory Monitoring

```swift
// Monitor memory usage
let memoryMonitor = MemoryMonitor()
let currentMemoryUsage = memoryMonitor.getCurrentMemoryUsage()
print("Current memory usage: \(currentMemoryUsage)MB")

// Monitor memory leaks
memoryMonitor.startLeakDetection()
memoryMonitor.onMemoryLeakDetected { leak in
    print("🚨 Memory leak detected: \(leak.description)")
}
```

## Data Export

### Export User Data

```swift
// Export user data
let exportManager = DataExportManager()
exportManager.exportUserData(userId: "user_123") { result in
    switch result {
    case .success(let data):
        print("User data exported successfully")
        print("Data size: \(data.size) bytes")
        data.saveToFile("user_123_data.json")
        
    case .failure(let error):
        print("Export failed: \(error)")
    }
}
```

### Data Deletion

```swift
// Delete user data
let deletionManager = DataDeletionManager()
deletionManager.deleteUserData(userId: "user_123") { result in
    switch result {
    case .success(let deletionStats):
        print("User data deleted successfully")
        print("Records deleted: \(deletionStats.recordsDeleted)")
        
    case .failure(let error):
        print("Deletion failed: \(error)")
    }
}
```

## Best Practices

### 1. Initialize Early

```swift
// Initialize in AppDelegate
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // Initialize analytics early
    let analyticsEngine = AnalyticsEngine.shared
    let config = AnalyticsConfiguration()
    analyticsEngine.start(with: config)
    
    return true
}
```

### 2. Use Meaningful Event Names

```swift
// Good event names
analyticsEngine.trackEvent("purchase_completed")
analyticsEngine.trackEvent("subscription_started")
analyticsEngine.trackEvent("feature_activated")

// Avoid generic names
// analyticsEngine.trackEvent("click") // Too generic
// analyticsEngine.trackEvent("action") // Too generic
```

### 3. Include Relevant Properties

```swift
// Include useful context
analyticsEngine.trackEvent("purchase_completed", properties: [
    "product_id": "premium_subscription",
    "price": 9.99,
    "currency": "USD",
    "payment_method": "apple_pay",
    "user_segment": "premium"
])
```

### 4. Test Thoroughly

```swift
// Test in development
#if DEBUG
let testConfig = AnalyticsConfiguration()
testConfig.environment = .development
testConfig.logLevel = .debug
analyticsEngine.configure(testConfig)
#endif
```

### 5. Monitor Performance

```swift
// Monitor analytics impact
let performanceMonitor = PerformanceMonitor()
performanceMonitor.startMonitoring()

// Check analytics performance
let analyticsPerformance = performanceMonitor.getAnalyticsPerformance()
print("Analytics CPU usage: \(analyticsPerformance.cpuUsage)%")
print("Analytics memory usage: \(analyticsPerformance.memoryUsage)MB")
```

## Troubleshooting

### Common Issues

1. **Analytics not tracking**: Check if analytics engine is started
2. **Events not appearing**: Verify network connectivity
3. **Performance issues**: Monitor memory and CPU usage
4. **Privacy compliance**: Ensure consent is obtained

### Debug Mode

```swift
// Enable debug mode
let debugConfig = AnalyticsConfiguration()
debugConfig.logLevel = .debug
debugConfig.enableVerboseLogging = true
analyticsEngine.configure(debugConfig)
```

### Error Handling

```swift
// Handle analytics errors
analyticsEngine.onError { error in
    print("Analytics error: \(error)")
    
    switch error {
    case .networkError(let message):
        print("Network error: \(message)")
    case .storageError(let message):
        print("Storage error: \(message)")
    case .privacyViolation(let message):
        print("Privacy violation: \(message)")
    }
}
```

## Next Steps

1. **Explore Examples**: Check the Examples directory for more detailed implementations
2. **Read Documentation**: Review the API documentation for advanced features
3. **Join Community**: Contribute to the project and get help from the community
4. **Customize**: Adapt the framework to your specific needs
5. **Monitor**: Set up monitoring and alerting for your analytics implementation

## Support

- **Documentation**: [API Documentation](Documentation/)
- **Examples**: [Code Examples](Examples/)
- **Issues**: [GitHub Issues](https://github.com/muhittincamdali/iOS-Analytics-Engine-Pro/issues)
- **Discussions**: [GitHub Discussions](https://github.com/muhittincamdali/iOS-Analytics-Engine-Pro/discussions)
