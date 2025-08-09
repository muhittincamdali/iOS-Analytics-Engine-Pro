# Basic Examples

<!-- TOC START -->
## Table of Contents
- [Basic Examples](#basic-examples)
- [Examples](#examples)
  - [1. Simple Event Tracking](#1-simple-event-tracking)
  - [2. User Properties](#2-user-properties)
  - [3. Event with Properties](#3-event-with-properties)
  - [4. Screen Tracking](#4-screen-tracking)
- [Getting Started](#getting-started)
- [Best Practices](#best-practices)
<!-- TOC END -->


This directory contains basic examples demonstrating fundamental analytics functionality.

## Examples

### 1. Simple Event Tracking

```swift
import AnalyticsEnginePro

// Initialize analytics engine
let analyticsEngine = AnalyticsEngine.shared

// Configure analytics
let config = AnalyticsConfiguration()
config.enableAutomaticTracking = true
analyticsEngine.start(with: config)

// Track basic events
analyticsEngine.trackEvent("app_launched")
analyticsEngine.trackEvent("button_clicked")
analyticsEngine.trackEvent("screen_viewed", properties: [
    "screen_name": "HomeScreen"
])
```

### 2. User Properties

```swift
// Set user properties
analyticsEngine.setUserProperty("subscription_type", value: "premium")
analyticsEngine.setUserProperty("user_segment", value: "high_value")
analyticsEngine.setUserProperty("app_version", value: "1.2.3")

// Set user ID
analyticsEngine.setUserID("user_12345")
```

### 3. Event with Properties

```swift
// Track events with rich properties
analyticsEngine.trackEvent("purchase_completed", properties: [
    "product_id": "premium_subscription",
    "price": 9.99,
    "currency": "USD",
    "payment_method": "apple_pay",
    "user_segment": "premium"
])
```

### 4. Screen Tracking

```swift
// Track screen views
analyticsEngine.trackEvent("screen_viewed", properties: [
    "screen_name": "ProductDetail",
    "product_id": "12345",
    "category": "electronics"
])
```

## Getting Started

1. Import the framework
2. Initialize the analytics engine
3. Configure settings
4. Start tracking events
5. Set user properties as needed

## Best Practices

- Use descriptive event names
- Include relevant properties
- Test in development environment
- Respect user privacy
- Follow consistent naming conventions 