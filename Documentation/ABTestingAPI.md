# A/B Testing API

<!-- TOC START -->
## Table of Contents
- [A/B Testing API](#ab-testing-api)
- [Overview](#overview)
- [Core Classes](#core-classes)
  - [ABTestManager](#abtestmanager)
  - [ABTestExperiment](#abtestexperiment)
  - [ExperimentVariation](#experimentvariation)
- [Experiment Setup](#experiment-setup)
  - [Creating Experiments](#creating-experiments)
  - [Starting Experiments](#starting-experiments)
- [User Assignment](#user-assignment)
  - [Assigning Users to Variations](#assigning-users-to-variations)
  - [Traffic Allocation](#traffic-allocation)
- [Conversion Tracking](#conversion-tracking)
  - [Tracking Conversions](#tracking-conversions)
  - [Conversion Types](#conversion-types)
- [Results Analysis](#results-analysis)
  - [Getting Experiment Results](#getting-experiment-results)
  - [Statistical Analysis](#statistical-analysis)
  - [Real-time Monitoring](#real-time-monitoring)
- [Advanced Features](#advanced-features)
  - [Multi-variant Testing](#multi-variant-testing)
  - [Targeting Rules](#targeting-rules)
  - [Guardrail Metrics](#guardrail-metrics)
- [Experiment Lifecycle](#experiment-lifecycle)
  - [Managing Experiments](#managing-experiments)
  - [Experiment Reporting](#experiment-reporting)
- [Best Practices](#best-practices)
<!-- TOC END -->


## Overview

The A/B Testing API provides comprehensive A/B testing and experimentation capabilities for iOS applications. This document covers all A/B testing interfaces and methods available in the Analytics Engine Pro framework.

## Core Classes

### ABTestManager

The main class for A/B testing functionality.

```swift
public class ABTestManager {
    public static let shared = ABTestManager()
    
    public func createExperiment(_ experiment: ABTestExperiment) -> Bool
    public func startExperiment(_ experimentId: String) -> Bool
    public func stopExperiment(_ experimentId: String) -> Bool
    public func getExperimentResults(_ experimentId: String) -> ExperimentResults
    public func assignUserToVariation(_ userId: String, _ experimentId: String) -> ExperimentVariation?
    public func trackConversion(_ experimentId: String, _ userId: String, _ conversionType: String, _ value: Double)
}
```

### ABTestExperiment

Class representing an A/B test experiment.

```swift
public class ABTestExperiment {
    public let id: String
    public let name: String
    public let description: String
    public var variations: [ExperimentVariation]
    public var trafficAllocation: Double
    public var primaryMetric: String
    public var significanceLevel: Double
    public var startDate: Date?
    public var endDate: Date?
    public var status: ExperimentStatus
}
```

### ExperimentVariation

Class representing an experiment variation.

```swift
public class ExperimentVariation {
    public let id: String
    public let name: String
    public let properties: [String: Any]
    public var trafficPercentage: Double
    public var isControl: Bool
}
```

## Experiment Setup

### Creating Experiments

```swift
// Create a new A/B test experiment
let experiment = ABTestExperiment(
    id: "button_color_test",
    name: "Button Color Optimization",
    description: "Test different button colors for conversion optimization"
)

// Define experiment variations
let variations = [
    ExperimentVariation(
        id: "control",
        name: "Control (Blue)",
        properties: ["button_color": "blue"],
        trafficPercentage: 25.0,
        isControl: true
    ),
    ExperimentVariation(
        id: "green",
        name: "Green Button",
        properties: ["button_color": "green"],
        trafficPercentage: 25.0,
        isControl: false
    ),
    ExperimentVariation(
        id: "red",
        name: "Red Button",
        properties: ["button_color": "red"],
        trafficPercentage: 25.0,
        isControl: false
    ),
    ExperimentVariation(
        id: "orange",
        name: "Orange Button",
        properties: ["button_color": "orange"],
        trafficPercentage: 25.0,
        isControl: false
    )
]

experiment.variations = variations
experiment.trafficAllocation = 0.1 // 10% of users
experiment.primaryMetric = "conversion_rate"
experiment.significanceLevel = 0.05

// Create the experiment
let abTestManager = ABTestManager.shared
let success = abTestManager.createExperiment(experiment)
```

### Starting Experiments

```swift
// Start the experiment
let started = abTestManager.startExperiment("button_color_test")
if started {
    print("Experiment started successfully")
} else {
    print("Failed to start experiment")
}
```

## User Assignment

### Assigning Users to Variations

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
    
    // Track assignment
    analyticsEngine.trackEvent("experiment_assigned", properties: [
        "experiment_id": "button_color_test",
        "variation_id": variation.id,
        "user_id": "user_123"
    ])
} else {
    print("User not assigned to experiment")
}
```

### Traffic Allocation

```swift
// Configure traffic allocation
let trafficConfig = TrafficAllocationConfiguration()

// Set allocation percentages
trafficConfig.setAllocation("control", percentage: 25)
trafficConfig.setAllocation("green", percentage: 25)
trafficConfig.setAllocation("red", percentage: 25)
trafficConfig.setAllocation("orange", percentage: 25)

// Apply traffic allocation
abTestManager.configureTrafficAllocation("button_color_test", config: trafficConfig)
```

## Conversion Tracking

### Tracking Conversions

```swift
// Track conversion events
abTestManager.trackConversion(
    experimentId: "button_color_test",
    userId: "user_123",
    conversionType: "purchase",
    value: 19.99
)

// Track multiple conversion types
abTestManager.trackConversion(
    experimentId: "button_color_test",
    userId: "user_123",
    conversionType: "signup",
    value: 0.0
)

abTestManager.trackConversion(
    experimentId: "button_color_test",
    userId: "user_123",
    conversionType: "email_subscription",
    value: 0.0
)
```

### Conversion Types

```swift
// Define conversion types
enum ConversionType: String {
    case purchase = "purchase"
    case signup = "signup"
    case subscription = "subscription"
    case emailSubscription = "email_subscription"
    case featureUsage = "feature_usage"
    case engagement = "engagement"
}

// Track conversions with types
abTestManager.trackConversion(
    experimentId: "button_color_test",
    userId: "user_123",
    conversionType: ConversionType.purchase.rawValue,
    value: 29.99
)
```

## Results Analysis

### Getting Experiment Results

```swift
// Get experiment results
let results = abTestManager.getExperimentResults("button_color_test")

print("Experiment Results:")
print("Status: \(results.status)")
print("Total participants: \(results.totalParticipants)")
print("Duration: \(results.duration) days")

// Control group results
print("Control conversion rate: \(results.control.conversionRate)%")
print("Control sample size: \(results.control.sampleSize)")

// Variation results
for (variationId, variation) in results.variations {
    print("\(variationId) conversion rate: \(variation.conversionRate)%")
    print("\(variationId) sample size: \(variation.sampleSize)")
}
```

### Statistical Analysis

```swift
// Perform statistical analysis
let statisticalAnalysis = abTestManager.performStatisticalAnalysis("button_color_test")

print("Statistical Analysis Results:")
print("Chi-square test: \(statisticalAnalysis.chiSquareTest)")
print("T-test results: \(statisticalAnalysis.tTestResults)")
print("Confidence intervals: \(statisticalAnalysis.confidenceIntervals)")
print("Effect size: \(statisticalAnalysis.effectSize)")

// Check statistical significance
if statisticalAnalysis.isStatisticallySignificant {
    print("✅ Results are statistically significant")
    if let winner = statisticalAnalysis.winner {
        print("🏆 Winner: \(winner)")
    }
} else {
    print("⏳ Need more data for statistical significance")
}
```

### Real-time Monitoring

```swift
// Monitor experiment in real-time
abTestManager.monitorExperiment("button_color_test") { results in
    print("Real-time Results:")
    print("Control conversion rate: \(results.control.conversionRate)%")
    
    for (variationId, variation) in results.variations {
        print("\(variationId) conversion rate: \(variation.conversionRate)%")
    }
    
    if results.isStatisticallySignificant {
        print("✅ Results are statistically significant")
    } else {
        print("⏳ Need more data")
    }
}
```

## Advanced Features

### Multi-variant Testing

```swift
// Create multi-variant experiment
let multiVariantExperiment = ABTestExperiment(
    id: "landing_page_test",
    name: "Landing Page Optimization",
    description: "Test different landing page layouts"
)

// Define multiple variations
let landingPageVariations = [
    ExperimentVariation(
        id: "control",
        name: "Control Layout",
        properties: [
            "header_style": "minimal",
            "cta_position": "bottom",
            "color_scheme": "blue"
        ],
        trafficPercentage: 20.0,
        isControl: true
    ),
    ExperimentVariation(
        id: "variant_a",
        name: "Bold Header",
        properties: [
            "header_style": "bold",
            "cta_position": "bottom",
            "color_scheme": "blue"
        ],
        trafficPercentage: 20.0,
        isControl: false
    ),
    ExperimentVariation(
        id: "variant_b",
        name: "Top CTA",
        properties: [
            "header_style": "minimal",
            "cta_position": "top",
            "color_scheme": "blue"
        ],
        trafficPercentage: 20.0,
        isControl: false
    ),
    ExperimentVariation(
        id: "variant_c",
        name: "Green Theme",
        properties: [
            "header_style": "minimal",
            "cta_position": "bottom",
            "color_scheme": "green"
        ],
        trafficPercentage: 20.0,
        isControl: false
    ),
    ExperimentVariation(
        id: "variant_d",
        name: "Combined Changes",
        properties: [
            "header_style": "bold",
            "cta_position": "top",
            "color_scheme": "green"
        ],
        trafficPercentage: 20.0,
        isControl: false
    )
]

multiVariantExperiment.variations = landingPageVariations
multiVariantExperiment.primaryMetric = "signup_rate"
multiVariantExperiment.secondaryMetrics = ["time_on_page", "scroll_depth"]
```

### Targeting Rules

```swift
// Set targeting rules for experiment
let targetingRules = [
    TargetingRule(field: "user_segment", operator: .equals, value: "premium"),
    TargetingRule(field: "app_version", operator: .greaterThan, value: "1.5.0"),
    TargetingRule(field: "device_type", operator: .in, value: ["iPhone", "iPad"])
]

experiment.targetingRules = targetingRules
```

### Guardrail Metrics

```swift
// Set guardrail metrics
experiment.guardrailMetrics = [
    "crash_rate",
    "session_duration",
    "battery_usage"
]

// Monitor guardrail metrics
abTestManager.monitorGuardrailMetrics("button_color_test") { metrics in
    if metrics.crashRate > 5.0 {
        print("🚨 High crash rate detected: \(metrics.crashRate)%")
        abTestManager.stopExperiment("button_color_test")
    }
}
```

## Experiment Lifecycle

### Managing Experiments

```swift
// Pause experiment
abTestManager.pauseExperiment("button_color_test")

// Resume experiment
abTestManager.resumeExperiment("button_color_test")

// Stop experiment
abTestManager.stopExperiment("button_color_test")

// Archive experiment
abTestManager.archiveExperiment("button_color_test")
```

### Experiment Reporting

```swift
// Generate experiment report
let report = abTestManager.generateReport("button_color_test")

print("Experiment Report:")
print("Duration: \(report.duration) days")
print("Total participants: \(report.totalParticipants)")
print("Conversions: \(report.totalConversions)")
print("Conversion rate: \(report.overallConversionRate)%")
print("Statistical significance: \(report.isStatisticallySignificant ? "Yes" : "No")")
print("Recommended action: \(report.recommendedAction)")

// Export report data
let reportData = abTestManager.exportReportData("button_color_test")
```

## Best Practices

1. **Start small**: Begin with small traffic allocations
2. **Monitor closely**: Watch for unexpected impacts
3. **Use guardrails**: Set up safety metrics
4. **Test one variable**: Focus on single changes
5. **Wait for significance**: Don't end experiments too early
6. **Document everything**: Keep detailed experiment logs
7. **Learn from results**: Apply insights to future tests
8. **Respect user experience**: Don't compromise UX for testing
