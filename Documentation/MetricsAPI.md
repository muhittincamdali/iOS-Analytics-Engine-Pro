# Metrics API

## Overview

The Metrics API provides comprehensive metrics and KPIs calculation capabilities for iOS applications. This document covers all metrics-related interfaces and methods available in the Analytics Engine Pro framework.

## Core Classes

### MetricsCalculator

The main class for metrics calculation functionality.

```swift
public class MetricsCalculator {
    public static let shared = MetricsCalculator()
    
    public func calculateUserMetrics() -> UserMetrics
    public func calculateBusinessMetrics() -> BusinessMetrics
    public func calculatePerformanceMetrics() -> PerformanceMetrics
    public func calculateCustomMetrics() -> CustomMetrics
    public func calculateRealTimeMetrics() -> RealTimeMetrics
}
```

### UserMetrics

Class for user-related metrics calculation.

```swift
public class UserMetrics {
    public func calculateDAU() -> Int
    public func calculateMAU() -> Int
    public func calculateRetention(days: Int) -> Double
    public func calculateEngagement() -> Double
    public func calculateAverageSessionDuration() -> TimeInterval
    public func calculateUserLifetime() -> TimeInterval
    public func calculateChurnRate() -> Double
    public func calculateActivationRate() -> Double
}
```

### BusinessMetrics

Class for business-related metrics calculation.

```swift
public class BusinessMetrics {
    public func calculateMRR() -> Double
    public func calculateARR() -> Double
    public func calculateCAC() -> Double
    public func calculateLTV() -> Double
    public func calculateConversionRate() -> Double
    public func calculateRevenuePerUser() -> Double
    public func calculateAverageOrderValue() -> Double
    public func calculateCustomerLifetimeValue() -> Double
}
```

## User Metrics

### Daily Active Users (DAU)

```swift
// Calculate DAU
let userMetrics = UserMetrics()
let dau = userMetrics.calculateDAU()
print("Daily Active Users: \(dau)")

// Calculate DAU with filters
let premiumDAU = userMetrics.calculateDAU(filters: [
    "user_segment": "premium",
    "subscription_status": "active"
])
```

### Monthly Active Users (MAU)

```swift
// Calculate MAU
let mau = userMetrics.calculateMAU()
print("Monthly Active Users: \(mau)")

// Calculate MAU by segment
let segmentMAU = userMetrics.calculateMAU(segment: "high_value")
```

### User Retention

```swift
// Calculate retention rates
let retention7Days = userMetrics.calculateRetention(days: 7)
let retention30Days = userMetrics.calculateRetention(days: 30)
let retention90Days = userMetrics.calculateRetention(days: 90)

print("7-day retention: \(retention7Days)%")
print("30-day retention: \(retention30Days)%")
print("90-day retention: \(retention90Days)%")
```

### User Engagement

```swift
// Calculate engagement metrics
let engagementScore = userMetrics.calculateEngagement()
let sessionDuration = userMetrics.calculateAverageSessionDuration()
let sessionsPerUser = userMetrics.calculateSessionsPerUser()

print("Engagement score: \(engagementScore)")
print("Average session duration: \(sessionDuration)s")
print("Sessions per user: \(sessionsPerUser)")
```

## Business Metrics

### Monthly Recurring Revenue (MRR)

```swift
// Calculate MRR
let businessMetrics = BusinessMetrics()
let mrr = businessMetrics.calculateMRR()
print("Monthly Recurring Revenue: $\(mrr)")

// Calculate MRR by plan
let planMRR = businessMetrics.calculateMRR(plan: "premium")
```

### Customer Acquisition Cost (CAC)

```swift
// Calculate CAC
let cac = businessMetrics.calculateCAC()
print("Customer Acquisition Cost: $\(cac)")

// Calculate CAC by channel
let channelCAC = businessMetrics.calculateCAC(channel: "app_store")
```

### Customer Lifetime Value (LTV)

```swift
// Calculate LTV
let ltv = businessMetrics.calculateLTV()
print("Customer Lifetime Value: $\(ltv)")

// Calculate LTV by segment
let segmentLTV = businessMetrics.calculateLTV(segment: "premium")
```

### Conversion Rates

```swift
// Calculate conversion rates
let signupConversion = businessMetrics.calculateConversionRate(funnel: "signup")
let purchaseConversion = businessMetrics.calculateConversionRate(funnel: "purchase")
let subscriptionConversion = businessMetrics.calculateConversionRate(funnel: "subscription")

print("Signup conversion: \(signupConversion)%")
print("Purchase conversion: \(purchaseConversion)%")
print("Subscription conversion: \(subscriptionConversion)%")
```

## Performance Metrics

### App Performance

```swift
// Calculate performance metrics
let performanceMetrics = PerformanceMetrics()

let launchTime = performanceMetrics.calculateAverageLaunchTime()
let crashRate = performanceMetrics.calculateCrashRate()
let apiResponseTime = performanceMetrics.calculateAverageAPITime()
let memoryUsage = performanceMetrics.calculateAverageMemoryUsage()

print("Average launch time: \(launchTime)s")
print("Crash rate: \(crashRate)%")
print("Average API response time: \(apiResponseTime)s")
print("Average memory usage: \(memoryUsage)MB")
```

### Network Performance

```swift
// Calculate network metrics
let networkMetrics = NetworkMetrics()

let downloadSpeed = networkMetrics.calculateAverageDownloadSpeed()
let uploadSpeed = networkMetrics.calculateAverageUploadSpeed()
let connectionSuccessRate = networkMetrics.calculateConnectionSuccessRate()

print("Average download speed: \(downloadSpeed) Mbps")
print("Average upload speed: \(uploadSpeed) Mbps")
print("Connection success rate: \(connectionSuccessRate)%")
```

## Custom Metrics

### Custom KPI Definition

```swift
// Define custom metrics
let customMetrics = CustomMetrics()

// Define custom KPI
let customKPI = CustomKPI(
    name: "feature_adoption_rate",
    calculation: "users_with_feature / total_users * 100",
    description: "Percentage of users who adopted the new feature"
)

// Calculate custom metric
let adoptionRate = customMetrics.calculateMetric(customKPI)
print("Feature adoption rate: \(adoptionRate)%")
```

### Complex Metric Calculations

```swift
// Calculate complex metrics
let complexMetrics = ComplexMetricsCalculator()

// Revenue per active user
let revenuePerActiveUser = complexMetrics.calculateRevenuePerActiveUser()

// User engagement score
let engagementScore = complexMetrics.calculateEngagementScore()

// Feature usage index
let featureUsageIndex = complexMetrics.calculateFeatureUsageIndex()

print("Revenue per active user: $\(revenuePerActiveUser)")
print("Engagement score: \(engagementScore)")
print("Feature usage index: \(featureUsageIndex)")
```

## Real-time Metrics

### Real-time Dashboard

```swift
// Create real-time metrics dashboard
let realTimeMetrics = RealTimeMetrics()

// Subscribe to real-time updates
realTimeMetrics.subscribeToUpdates { metrics in
    print("Real-time Metrics:")
    print("Active users: \(metrics.activeUsers)")
    print("Current revenue: $\(metrics.currentRevenue)")
    print("Conversion rate: \(metrics.conversionRate)%")
    print("Average session time: \(metrics.averageSessionTime)s")
}

// Start real-time monitoring
realTimeMetrics.startMonitoring()
```

### Real-time Alerts

```swift
// Configure real-time alerts
let alertManager = MetricsAlertManager()

// Set up alerts
alertManager.setAlert(
    metric: "crash_rate",
    threshold: 5.0,
    condition: .greaterThan
) { alert in
    print("🚨 High crash rate detected: \(alert.value)%")
}

alertManager.setAlert(
    metric: "revenue",
    threshold: 1000.0,
    condition: .lessThan
) { alert in
    print("⚠️ Low revenue alert: $\(alert.value)")
}
```

## Historical Metrics

### Trend Analysis

```swift
// Analyze metric trends
let trendAnalyzer = MetricsTrendAnalyzer()

// Get trend data
let dauTrend = trendAnalyzer.getTrend(metric: "dau", timeRange: lastMonth)
let revenueTrend = trendAnalyzer.getTrend(metric: "revenue", timeRange: lastQuarter)

print("DAU Trend: \(dauTrend.direction) \(dauTrend.percentageChange)%")
print("Revenue Trend: \(revenueTrend.direction) \(revenueTrend.percentageChange)%")
```

### Cohort Analysis

```swift
// Perform cohort analysis
let cohortAnalyzer = CohortAnalyzer()

// Analyze user cohorts
let cohortData = cohortAnalyzer.analyzeCohorts(
    timeRange: lastYear,
    metric: "retention"
)

for cohort in cohortData {
    print("Cohort: \(cohort.month)")
    print("Size: \(cohort.size)")
    print("Retention rates: \(cohort.retentionRates)")
}
```

## Best Practices

1. **Define clear metrics**: Use well-defined, measurable KPIs
2. **Monitor regularly**: Track metrics on a consistent schedule
3. **Set benchmarks**: Establish baseline and target values
4. **Use real-time data**: Monitor critical metrics in real-time
5. **Analyze trends**: Look for patterns and changes over time
6. **Validate data**: Ensure metric calculations are accurate
7. **Document methodology**: Clearly document how metrics are calculated
8. **Review and adjust**: Regularly review and update metrics as needed
