# Event Tracking Examples

This directory contains comprehensive examples demonstrating event tracking capabilities.

## Examples

### 1. Automatic Event Tracking

```swift
import AnalyticsEnginePro

// Configure automatic event tracking
let autoTracking = AutomaticEventTracking()

// Enable automatic tracking features
autoTracking.enableScreenTracking = true
autoTracking.enableAppLifecycleTracking = true
autoTracking.enableGestureTracking = true
autoTracking.enableNetworkTracking = true

// Configure tracking options
autoTracking.screenTrackingOptions = [
    .trackScreenViews,
    .trackScreenTime,
    .trackScreenInteractions
]

autoTracking.appLifecycleOptions = [
    .trackAppLaunches,
    .trackAppBackgrounding,
    .trackAppForegrounding,
    .trackAppTermination
]

// Start automatic tracking
autoTracking.startTracking()
```

### 2. Custom Event Tracking

```swift
// Create custom event tracker
let customTracker = CustomEventTracker()

// Track user interactions
customTracker.trackEvent("button_clicked", properties: [
    "button_id": "subscribe_button",
    "button_location": "home_screen",
    "user_segment": "free_user",
    "click_timestamp": Date()
])

customTracker.trackEvent("form_submitted", properties: [
    "form_type": "registration",
    "completion_time": 45.2,
    "fields_filled": 8,
    "validation_errors": 0
])

customTracker.trackEvent("content_viewed", properties: [
    "content_type": "article",
    "content_id": "12345",
    "content_category": "technology",
    "view_duration": 120,
    "scroll_depth": 75
])
```

### 3. Event Validation

```swift
// Configure event validation
let eventValidator = EventValidator()

// Add validation rules
eventValidator.addValidationRule("purchase_amount", rule: .positiveNumber)
eventValidator.addValidationRule("user_id", rule: .required)
eventValidator.addValidationRule("event_timestamp", rule: .validTimestamp)
eventValidator.addValidationRule("email", rule: .maxLength(100))

// Process events with validation
let eventProcessor = EventProcessor(validator: eventValidator)

eventProcessor.processEvent("purchase_completed", properties: [
    "purchase_amount": 19.99,
    "user_id": "user_123",
    "event_timestamp": Date(),
    "email": "user@example.com"
]) { result in
    switch result {
    case .success(let event):
        print("Event processed successfully: \(event)")
    case .failure(let error):
        print("Event validation failed: \(error)")
    }
}
```

### 4. Event Batching

```swift
// Configure event batching
let eventBatcher = EventBatcher()
eventBatcher.batchSize = 50
eventBatcher.flushInterval = 15.0

// Add events to batch
eventBatcher.addEvent(AnalyticsEvent(name: "page_view", properties: pageViewProps))
eventBatcher.addEvent(AnalyticsEvent(name: "button_click", properties: buttonClickProps))
eventBatcher.addEvent(AnalyticsEvent(name: "form_submit", properties: formSubmitProps))

// Manually flush batch
eventBatcher.flush()
```

### 5. Event Enrichment

```swift
// Create event enricher
class EventEnricher: EventProcessor {
    override func enrichEvent(_ event: AnalyticsEvent) -> EnrichedEvent {
        var enrichedEvent = event
        
        // Add device information
        enrichedEvent.properties["device_model"] = UIDevice.current.model
        enrichedEvent.properties["ios_version"] = UIDevice.current.systemVersion
        enrichedEvent.properties["app_version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        // Add session information
        enrichedEvent.properties["session_id"] = SessionManager.shared.currentSessionId
        enrichedEvent.properties["session_duration"] = SessionManager.shared.sessionDuration
        
        // Add user context
        if let user = UserManager.shared.currentUser {
            enrichedEvent.properties["user_segment"] = user.segment
            enrichedEvent.properties["user_type"] = user.type
        }
        
        return EnrichedEvent(event: enrichedEvent)
    }
}
```

### 6. Event Filtering

```swift
// Create event filter
class EventFilter: EventProcessor {
    override func filterEvent(_ event: AnalyticsEvent) -> Bool {
        // Filter out sensitive events in development
        #if DEBUG
        if event.name.contains("password") || event.name.contains("credit_card") {
            return false
        }
        #endif
        
        // Filter out events with invalid properties
        if event.properties["user_id"] == nil {
            return false
        }
        
        return true
    }
}
```

### 7. Real-time Event Tracking

```swift
// Configure real-time event tracking
let realTimeTracker = RealTimeEventTracker()
realTimeTracker.enableRealTimeTracking = true
realTimeTracker.updateInterval = 2.0

// Track real-time events
realTimeTracker.trackRealTimeEvent("user_typing", properties: [
    "input_field": "search_box",
    "character_count": 15
])

realTimeTracker.trackRealTimeEvent("mouse_movement", properties: [
    "x_coordinate": 150,
    "y_coordinate": 200,
    "element_id": "product_card"
])
```

### 8. Event Analytics

```swift
// Analyze event patterns
let eventAnalytics = EventAnalytics()

// Get event frequency
let eventFrequency = eventAnalytics.getEventFrequency("button_clicked", timeRange: lastWeek)
print("Button clicks this week: \(eventFrequency)")

// Get event trends
let eventTrends = eventAnalytics.getEventTrends("purchase_completed", timeRange: lastMonth)
print("Purchase trend: \(eventTrends)")

// Get event correlations
let correlations = eventAnalytics.getEventCorrelations("screen_viewed", "button_clicked")
print("Screen view to button click correlation: \(correlations)")
```

## Best Practices

1. **Use descriptive event names**: Clear, consistent naming
2. **Include relevant properties**: Add context without sensitive data
3. **Validate event data**: Ensure data quality and format
4. **Batch events efficiently**: Balance real-time vs. performance
5. **Respect user privacy**: Don't track sensitive information
6. **Test thoroughly**: Validate events in development
7. **Monitor performance**: Watch for impact on app performance
8. **Document events**: Maintain clear documentation of event schema 