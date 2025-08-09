# Event Tracking API

<!-- TOC START -->
## Table of Contents
- [Event Tracking API](#event-tracking-api)
- [Overview](#overview)
- [Core Classes](#core-classes)
  - [EventTracker](#eventtracker)
  - [AutomaticEventTracking](#automaticeventtracking)
- [Event Types](#event-types)
  - [Screen Events](#screen-events)
  - [User Action Events](#user-action-events)
  - [Error Events](#error-events)
  - [Performance Events](#performance-events)
- [Event Properties](#event-properties)
  - [Standard Properties](#standard-properties)
  - [Custom Properties](#custom-properties)
- [Event Validation](#event-validation)
  - [EventValidator](#eventvalidator)
- [Event Processing](#event-processing)
  - [EventProcessor](#eventprocessor)
- [Event Batching](#event-batching)
  - [EventBatcher](#eventbatcher)
- [Best Practices](#best-practices)
- [Error Handling](#error-handling)
- [Performance Considerations](#performance-considerations)
<!-- TOC END -->


## Overview

The Event Tracking API provides comprehensive event tracking capabilities for iOS applications. This document covers all event tracking interfaces and methods available in the Analytics Engine Pro framework.

## Core Classes

### EventTracker

The main class for event tracking functionality.

```swift
public class EventTracker {
    public static let shared = EventTracker()
    
    public func trackEvent(_ eventName: String, properties: [String: Any]?)
    public func trackScreen(_ screenName: String, properties: [String: Any]?)
    public func trackUserAction(_ action: String, properties: [String: Any]?)
    public func trackError(_ error: Error, properties: [String: Any]?)
    public func trackPerformance(_ metric: String, value: Double, properties: [String: Any]?)
}
```

### AutomaticEventTracking

Class for automatic event tracking configuration.

```swift
public class AutomaticEventTracking {
    public var enableScreenTracking: Bool = true
    public var enableAppLifecycleTracking: Bool = true
    public var enableGestureTracking: Bool = false
    public var enableNetworkTracking: Bool = false
    
    public func startTracking()
    public func stopTracking()
    public func configure(_ options: TrackingOptions)
}
```

## Event Types

### Screen Events

```swift
// Track screen views
eventTracker.trackScreen("HomeScreen", properties: [
    "user_type": "premium",
    "source": "navigation"
])

// Track screen time
eventTracker.trackScreen("ProductDetail", properties: [
    "product_id": "12345",
    "view_duration": 120.5
])
```

### User Action Events

```swift
// Track button clicks
eventTracker.trackUserAction("button_clicked", properties: [
    "button_id": "subscribe_button",
    "button_location": "home_screen",
    "user_segment": "free_user"
])

// Track form submissions
eventTracker.trackUserAction("form_submitted", properties: [
    "form_type": "registration",
    "completion_time": 45.2,
    "fields_filled": 8
])
```

### Error Events

```swift
// Track errors
eventTracker.trackError(networkError, properties: [
    "endpoint": "/api/users",
    "response_code": 500,
    "retry_count": 3
])

// Track crashes
eventTracker.trackError(crashError, properties: [
    "crash_type": "memory_overflow",
    "stack_trace": crashStackTrace
])
```

### Performance Events

```swift
// Track performance metrics
eventTracker.trackPerformance("app_launch_time", value: 2.5, properties: [
    "device_model": "iPhone 14 Pro",
    "ios_version": "16.0"
])

eventTracker.trackPerformance("api_response_time", value: 0.8, properties: [
    "endpoint": "/api/data",
    "cache_hit": false
])
```

## Event Properties

### Standard Properties

```swift
// Common event properties
let standardProperties: [String: Any] = [
    "timestamp": Date(),
    "session_id": sessionID,
    "user_id": userID,
    "app_version": appVersion,
    "device_model": deviceModel,
    "ios_version": iosVersion
]
```

### Custom Properties

```swift
// Custom event properties
let customProperties: [String: Any] = [
    "feature_flag": "new_ui_enabled",
    "user_preference": "dark_mode",
    "experiment_group": "variant_a"
]
```

## Event Validation

### EventValidator

Class for validating event data.

```swift
public class EventValidator {
    public func validateEvent(_ eventName: String, properties: [String: Any]?) -> ValidationResult
    public func addValidationRule(_ propertyName: String, rule: ValidationRule)
    public func removeValidationRule(_ propertyName: String)
}

public enum ValidationRule {
    case required
    case string
    case number
    case boolean
    case positiveNumber
    case validTimestamp
    case maxLength(Int)
    case custom((Any) -> Bool)
}
```

## Event Processing

### EventProcessor

Class for processing and enriching events.

```swift
public class EventProcessor {
    public func processEvent(_ event: AnalyticsEvent) -> ProcessedEvent
    public func enrichEvent(_ event: AnalyticsEvent) -> EnrichedEvent
    public func filterEvent(_ event: AnalyticsEvent) -> Bool
}
```

## Event Batching

### EventBatcher

Class for efficient event batching.

```swift
public class EventBatcher {
    public var batchSize: Int = 100
    public var flushInterval: TimeInterval = 30
    
    public func addEvent(_ event: AnalyticsEvent)
    public func flush()
    public func clear()
}
```

## Best Practices

1. **Use consistent naming**: Follow a consistent event naming convention
2. **Include relevant context**: Add properties that provide useful context
3. **Validate data**: Ensure event data is valid before sending
4. **Respect privacy**: Don't track sensitive user information
5. **Optimize for performance**: Use batching and efficient processing
6. **Test thoroughly**: Validate events in development environment

## Error Handling

```swift
public enum EventTrackingError: Error {
    case invalidEventName
    case invalidProperties
    case networkError
    case storageError
    case quotaExceeded
    case privacyViolation
}
```

## Performance Considerations

- Events are processed asynchronously
- Batching reduces network overhead
- Local caching for offline scenarios
- Automatic retry for failed events
- Memory-efficient event storage
