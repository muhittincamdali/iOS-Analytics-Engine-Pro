# A/B Testing Examples

<!-- TOC START -->
## Table of Contents
- [A/B Testing Examples](#ab-testing-examples)
- [Examples](#examples)
  - [1. Basic A/B Test Setup](#1-basic-ab-test-setup)
  - [2. Multi-variant Testing](#2-multi-variant-testing)
  - [3. Real-time Results Monitoring](#3-real-time-results-monitoring)
  - [4. Traffic Allocation](#4-traffic-allocation)
  - [5. User Assignment](#5-user-assignment)
  - [6. Conversion Tracking](#6-conversion-tracking)
  - [7. Statistical Analysis](#7-statistical-analysis)
  - [8. Experiment Lifecycle Management](#8-experiment-lifecycle-management)
  - [9. Advanced Experiment Configuration](#9-advanced-experiment-configuration)
  - [10. Experiment Reporting](#10-experiment-reporting)
- [Best Practices](#best-practices)
<!-- TOC END -->


This directory contains comprehensive examples demonstrating A/B testing capabilities.

## Examples

### 1. Basic A/B Test Setup

```swift
import AnalyticsEnginePro

// Create A/B test experiment
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
        properties: ["button_color": "blue"]
    ),
    ExperimentVariation(
        id: "green",
        name: "Green Button",
        properties: ["button_color": "green"]
    ),
    ExperimentVariation(
        id: "red",
        name: "Red Button",
        properties: ["button_color": "red"]
    )
]

experiment.variations = variations
experiment.trafficAllocation = 0.1 // 10% of users
experiment.primaryMetric = "conversion_rate"
experiment.significanceLevel = 0.05

// Start experiment
let abTestManager = ABTestManager()
abTestManager.startExperiment(experiment)
```

### 2. Multi-variant Testing

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
        ]
    ),
    ExperimentVariation(
        id: "variant_a",
        name: "Bold Header",
        properties: [
            "header_style": "bold",
            "cta_position": "bottom",
            "color_scheme": "blue"
        ]
    ),
    ExperimentVariation(
        id: "variant_b",
        name: "Top CTA",
        properties: [
            "header_style": "minimal",
            "cta_position": "top",
            "color_scheme": "blue"
        ]
    ),
    ExperimentVariation(
        id: "variant_c",
        name: "Green Theme",
        properties: [
            "header_style": "minimal",
            "cta_position": "bottom",
            "color_scheme": "green"
        ]
    )
]

multiVariantExperiment.variations = landingPageVariations
multiVariantExperiment.trafficAllocation = 0.2 // 20% of users
multiVariantExperiment.primaryMetric = "signup_rate"
multiVariantExperiment.secondaryMetrics = ["time_on_page", "scroll_depth"]
```

### 3. Real-time Results Monitoring

```swift
// Monitor experiment results in real-time
abTestManager.getExperimentResults("button_color_test") { results in
    print("Experiment Results:")
    print("Control conversion rate: \(results.control.conversionRate)%")
    print("Green button conversion rate: \(results.variations["green"]?.conversionRate ?? 0)%")
    print("Red button conversion rate: \(results.variations["red"]?.conversionRate ?? 0)%")
    
    if results.isStatisticallySignificant {
        print("✅ Results are statistically significant")
        if let winner = results.winner {
            print("🏆 Winner: \(winner)")
        }
    } else {
        print("⏳ Need more data for statistical significance")
    }
}

// Get detailed statistics
let detailedStats = abTestManager.getDetailedStatistics("button_color_test")
print("Sample size: \(detailedStats.sampleSize)")
print("Confidence interval: \(detailedStats.confidenceInterval)")
print("P-value: \(detailedStats.pValue)")
```

### 4. Traffic Allocation

```swift
// Configure traffic allocation
let trafficConfig = TrafficAllocationConfiguration()

// Set allocation percentages
trafficConfig.setAllocation("control", percentage: 25)
trafficConfig.setAllocation("variant_a", percentage: 25)
trafficConfig.setAllocation("variant_b", percentage: 25)
trafficConfig.setAllocation("variant_c", percentage: 25)

// Apply traffic allocation
abTestManager.configureTrafficAllocation("landing_page_test", config: trafficConfig)
```

### 5. User Assignment

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
}
```

### 6. Conversion Tracking

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
    experimentId: "landing_page_test",
    userId: "user_456",
    conversionType: "signup",
    value: 0.0
)

abTestManager.trackConversion(
    experimentId: "landing_page_test",
    userId: "user_456",
    conversionType: "email_subscription",
    value: 0.0
)
```

### 7. Statistical Analysis

```swift
// Perform statistical analysis
let statisticalAnalysis = abTestManager.performStatisticalAnalysis("button_color_test")

print("Statistical Analysis Results:")
print("Chi-square test: \(statisticalAnalysis.chiSquareTest)")
print("T-test results: \(statisticalAnalysis.tTestResults)")
print("Confidence intervals: \(statisticalAnalysis.confidenceIntervals)")
print("Effect size: \(statisticalAnalysis.effectSize)")
```

### 8. Experiment Lifecycle Management

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

### 9. Advanced Experiment Configuration

```swift
// Create advanced experiment
let advancedExperiment = ABTestExperiment(
    id: "advanced_feature_test",
    name: "Advanced Feature Rollout",
    description: "Test new feature with gradual rollout"
)

// Configure advanced settings
advancedExperiment.trafficAllocation = 0.05 // 5% initial
advancedExperiment.autoScale = true
advancedExperiment.minimumSampleSize = 1000
advancedExperiment.maximumDuration = 30 // days
advancedExperiment.earlyStopping = true
advancedExperiment.primaryMetric = "revenue_per_user"
advancedExperiment.guardrailMetrics = ["crash_rate", "session_duration"]

// Set targeting rules
advancedExperiment.targetingRules = [
    TargetingRule(field: "user_segment", operator: .equals, value: "premium"),
    TargetingRule(field: "app_version", operator: .greaterThan, value: "1.5.0"),
    TargetingRule(field: "device_type", operator: .in, value: ["iPhone", "iPad"])
]
```

### 10. Experiment Reporting

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
// Save or send report data
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