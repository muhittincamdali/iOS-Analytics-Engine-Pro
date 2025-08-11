# API Reference

## Core Classes

### Main Framework

The main entry point for the iOS-Analytics-Engine-Pro framework.

```swift
public class iOS-Analytics-Engine-Pro {
    public init()
    public func configure()
    public func reset()
}
```

## Configuration

### Options

```swift
public struct Configuration {
    public var debugMode: Bool
    public var logLevel: LogLevel
    public var cacheEnabled: Bool
}
```

## Error Handling

```swift
public enum iOS-Analytics-Engine-ProError: Error {
    case configurationFailed
    case initializationError
    case runtimeError(String)
}
