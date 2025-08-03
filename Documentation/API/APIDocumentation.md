# API Documentation

## Analytics Engine Pro API Reference

### Core Classes

#### AnalyticsCore

The main analytics engine class that provides enterprise-grade analytics capabilities.

```swift
public final class AnalyticsCore
```

**Initialization:**
```swift
let analytics = AnalyticsCore(configuration: .init(apiKey: "your-api-key"))
```

**Key Methods:**
- `track(event:properties:completion:)` - Track analytics events
- `identify(userId:properties:completion:)` - Identify users
- `setUserProperties(_:completion:)` - Set user properties
- `startSession(completion:)` - Start user session
- `endSession(completion:)` - End user session
- `flush(completion:)` - Flush pending events
- `getPerformanceMetrics()` - Get performance metrics

#### AnalyticsConfiguration

Configuration for the analytics engine.

```swift
public struct AnalyticsConfiguration
```

**Properties:**
- `apiKey: String` - API key for authentication
- `environment: AnalyticsEnvironment` - Environment (development, staging, production)
- `realTimeTracking: Bool` - Enable real-time tracking
- `predictiveAnalytics: Bool` - Enable predictive analytics
- `abTesting: Bool` - Enable A/B testing
- `dataVisualization: Bool` - Enable data visualization
- `encryption: EncryptionType` - Encryption type (aes256, aes128, none)
- `compression: CompressionType` - Compression type (gzip, deflate, none)

#### AnalyticsEvent

Analytics event model.

```swift
public struct AnalyticsEvent
```

**Properties:**
- `name: String` - Event name
- `properties: [String: Any]` - Event properties
- `timestamp: Date` - Event timestamp
- `sessionId: String?` - Session identifier
- `userId: String?` - User identifier

### Error Types

#### AnalyticsError

Analytics error types.

```swift
public enum AnalyticsError: Error, LocalizedError
```

**Cases:**
- `.invalidEvent` - Invalid analytics event
- `.networkError` - Network communication error
- `.encryptionError` - Data encryption error
- `.storageError` - Data storage error
- `.configurationError` - Configuration error
- `.authenticationError` - Authentication error
- `.rateLimitExceeded` - Rate limit exceeded
- `.serverError` - Server error
- `.unknownError` - Unknown error

### Performance Metrics

#### PerformanceMetrics

Performance metrics for analytics engine.

```swift
public struct PerformanceMetrics
```

**Properties:**
- `eventLatency: TimeInterval` - Event processing latency
- `eventsPerSecond: Double` - Events processed per second
- `memoryUsage: Int64` - Memory usage in bytes
- `batteryImpact: Double` - Battery impact (0.0 to 1.0)
- `networkEfficiency: Double` - Network efficiency (0.0 to 1.0)
- `errorRate: Double` - Error rate (0.0 to 1.0)

### Usage Examples

#### Basic Event Tracking

```swift
import AnalyticsEnginePro

let analytics = AnalyticsCore(configuration: .init(apiKey: "your-api-key"))

// Track a simple event
analytics.track(event: "user_login", properties: [
    "method": "email",
    "timestamp": Date()
])
```

#### User Identification

```swift
// Identify a user
analytics.identify(userId: "user123", properties: [
    "name": "John Doe",
    "email": "john@example.com",
    "plan": "premium"
])
```

#### Session Management

```swift
// Start session
analytics.startSession { result in
    switch result {
    case .success:
        print("Session started")
    case .failure(let error):
        print("Failed to start session: \(error)")
    }
}

// End session
analytics.endSession { result in
    switch result {
    case .success:
        print("Session ended")
    case .failure(let error):
        print("Failed to end session: \(error)")
    }
}
```

#### Performance Monitoring

```swift
// Get performance metrics
let metrics = analytics.getPerformanceMetrics()
print("Event Latency: \(metrics.eventLatency)s")
print("Events Per Second: \(metrics.eventsPerSecond)")
print("Memory Usage: \(metrics.memoryUsage / 1024 / 1024)MB")
```

#### Error Handling

```swift
analytics.track(event: "test_event") { result in
    switch result {
    case .success:
        print("Event tracked successfully")
    case .failure(let error):
        switch error {
        case .invalidEvent:
            print("Invalid event")
        case .networkError:
            print("Network error")
        case .authenticationError:
            print("Authentication error")
        default:
            print("Unknown error: \(error)")
        }
    }
}
```

### Configuration Examples

#### Development Configuration

```swift
let devConfig = AnalyticsConfiguration(
    apiKey: "dev-api-key",
    environment: .development,
    realTimeTracking: true,
    predictiveAnalytics: false,
    abTesting: false,
    dataVisualization: false,
    autoStartSession: true,
    debugLogging: true
)
```

#### Production Configuration

```swift
let prodConfig = AnalyticsConfiguration(
    apiKey: "prod-api-key",
    environment: .production,
    realTimeTracking: true,
    predictiveAnalytics: true,
    abTesting: true,
    dataVisualization: true,
    encryption: .aes256,
    compression: .gzip,
    batchSize: 1000,
    flushInterval: 10,
    maxRetries: 5,
    timeout: 15,
    autoStartSession: true,
    debugLogging: false
)
```

#### Performance Configuration

```swift
let perfConfig = AnalyticsConfiguration.performance
```

#### Test Configuration

```swift
let testConfig = AnalyticsConfiguration.test
```

### Best Practices

1. **Event Naming**: Use descriptive, consistent event names
2. **Properties**: Include relevant context in event properties
3. **Error Handling**: Always handle potential errors
4. **Performance**: Monitor performance metrics regularly
5. **Security**: Use proper encryption and authentication
6. **Testing**: Test analytics implementation thoroughly

### Migration Guide

#### From v0.9.0 to v1.0.0

1. Update your Package.swift dependencies
2. Review API changes in the migration guide
3. Test your integration with the new features
4. Update your analytics configuration

### Support

For additional support and documentation, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOS-Analytics-Engine-Pro/issues)
- [GitHub Discussions](https://github.com/muhittincamdali/iOS-Analytics-Engine-Pro/discussions)
- [Documentation](Documentation/)
