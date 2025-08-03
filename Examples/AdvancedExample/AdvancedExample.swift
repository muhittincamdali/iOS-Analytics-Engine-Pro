import AnalyticsEnginePro
import Foundation

/// Advanced example demonstrating enterprise analytics features
/// This example shows how to use advanced analytics capabilities
/// including real-time tracking, predictive analytics, and A/B testing.
class AdvancedAnalyticsExample {
    
    private let analytics: AnalyticsCore
    
    init() {
        // Initialize analytics with advanced configuration
        let config = AnalyticsConfiguration(
            apiKey: "your-enterprise-api-key",
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
        
        self.analytics = AnalyticsCore(configuration: config)
    }
    
    /// Track complex user journey
    func trackUserJourney(userId: String, journeySteps: [String]) {
        for (index, step) in journeySteps.enumerated() {
            analytics.track(event: "journey_step", properties: [
                "user_id": userId,
                "step_name": step,
                "step_index": index,
                "total_steps": journeySteps.count,
                "timestamp": Date(),
                "session_id": UUID().uuidString
            ]) { result in
                switch result {
                case .success:
                    print("✅ Journey step tracked: \(step)")
                case .failure(let error):
                    print("❌ Failed to track journey step: \(error)")
                }
            }
        }
    }
    
    /// Track e-commerce events
    func trackEcommerceEvent(eventType: String, productData: [String: Any]) {
        analytics.track(event: "ecommerce_\(eventType)", properties: [
            "event_type": eventType,
            "product_id": productData["id"] as? String ?? "",
            "product_name": productData["name"] as? String ?? "",
            "product_price": productData["price"] as? Double ?? 0.0,
            "product_category": productData["category"] as? String ?? "",
            "currency": "USD",
            "timestamp": Date()
        ]) { result in
            switch result {
            case .success:
                print("✅ E-commerce event tracked: \(eventType)")
            case .failure(let error):
                print("❌ Failed to track e-commerce event: \(error)")
            }
        }
    }
    
    /// Track conversion funnel
    func trackConversionFunnel(userId: String, funnelName: String, step: String, stepData: [String: Any]) {
        analytics.track(event: "funnel_step", properties: [
            "user_id": userId,
            "funnel_name": funnelName,
            "step_name": step,
            "step_data": stepData,
            "timestamp": Date()
        ]) { result in
            switch result {
            case .success:
                print("✅ Funnel step tracked: \(step)")
            case .failure(let error):
                print("❌ Failed to track funnel step: \(error)")
            }
        }
    }
    
    /// Track user segmentation
    func trackUserSegmentation(userId: String, segments: [String]) {
        analytics.track(event: "user_segmentation", properties: [
            "user_id": userId,
            "segments": segments,
            "segment_count": segments.count,
            "timestamp": Date()
        ]) { result in
            switch result {
            case .success:
                print("✅ User segmentation tracked")
            case .failure(let error):
                print("❌ Failed to track user segmentation: \(error)")
            }
        }
    }
    
    /// Track performance metrics
    func trackPerformanceMetrics(metrics: [String: Any]) {
        analytics.track(event: "performance_metrics", properties: [
            "cpu_usage": metrics["cpu_usage"] as? Double ?? 0.0,
            "memory_usage": metrics["memory_usage"] as? Double ?? 0.0,
            "battery_level": metrics["battery_level"] as? Double ?? 0.0,
            "network_speed": metrics["network_speed"] as? Double ?? 0.0,
            "app_version": metrics["app_version"] as? String ?? "",
            "device_model": metrics["device_model"] as? String ?? "",
            "timestamp": Date()
        ]) { result in
            switch result {
            case .success:
                print("✅ Performance metrics tracked")
            case .failure(let error):
                print("❌ Failed to track performance metrics: \(error)")
            }
        }
    }
    
    /// Track custom events with complex data
    func trackCustomEvent(eventName: String, eventData: [String: Any]) {
        analytics.track(event: eventName, properties: eventData) { result in
            switch result {
            case .success:
                print("✅ Custom event tracked: \(eventName)")
            case .failure(let error):
                print("❌ Failed to track custom event: \(error)")
            }
        }
    }
    
    /// Batch track multiple events
    func batchTrackEvents(events: [[String: Any]]) {
        let group = DispatchGroup()
        
        for (index, eventData) in events.enumerated() {
            group.enter()
            
            analytics.track(event: eventData["name"] as? String ?? "batch_event_\(index)", properties: eventData) { result in
                switch result {
                case .success:
                    print("✅ Batch event tracked: \(index + 1)/\(events.count)")
                case .failure(let error):
                    print("❌ Failed to track batch event: \(error)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("✅ All batch events completed")
        }
    }
    
    /// Track user behavior patterns
    func trackUserBehavior(userId: String, behaviorPattern: [String: Any]) {
        analytics.track(event: "user_behavior", properties: [
            "user_id": userId,
            "behavior_type": behaviorPattern["type"] as? String ?? "",
            "behavior_data": behaviorPattern["data"] as? [String: Any] ?? [:],
            "session_duration": behaviorPattern["session_duration"] as? TimeInterval ?? 0,
            "interaction_count": behaviorPattern["interaction_count"] as? Int ?? 0,
            "timestamp": Date()
        ]) { result in
            switch result {
            case .success:
                print("✅ User behavior tracked")
            case .failure(let error):
                print("❌ Failed to track user behavior: \(error)")
            }
        }
    }
    
    /// Track A/B test exposure
    func trackABTestExposure(userId: String, testName: String, variant: String) {
        analytics.track(event: "ab_test_exposure", properties: [
            "user_id": userId,
            "test_name": testName,
            "variant": variant,
            "exposure_time": Date(),
            "timestamp": Date()
        ]) { result in
            switch result {
            case .success:
                print("✅ A/B test exposure tracked")
            case .failure(let error):
                print("❌ Failed to track A/B test exposure: \(error)")
            }
        }
    }
    
    /// Track predictive analytics events
    func trackPredictiveEvent(userId: String, predictionType: String, predictionData: [String: Any]) {
        analytics.track(event: "predictive_analytics", properties: [
            "user_id": userId,
            "prediction_type": predictionType,
            "prediction_data": predictionData,
            "confidence_score": predictionData["confidence"] as? Double ?? 0.0,
            "model_version": predictionData["model_version"] as? String ?? "",
            "timestamp": Date()
        ]) { result in
            switch result {
            case .success:
                print("✅ Predictive analytics event tracked")
            case .failure(let error):
                print("❌ Failed to track predictive analytics: \(error)")
            }
        }
    }
    
    /// Get comprehensive performance metrics
    func getComprehensiveMetrics() {
        let metrics = analytics.getPerformanceMetrics()
        
        print("📊 Comprehensive Performance Metrics:")
        print("   Event Latency: \(String(format: "%.3f", metrics.eventLatency))s")
        print("   Events Per Second: \(String(format: "%.1f", metrics.eventsPerSecond))")
        print("   Memory Usage: \(String(format: "%.1f", Double(metrics.memoryUsage) / 1024 / 1024))MB")
        print("   Battery Impact: \(String(format: "%.2f", metrics.batteryImpact * 100))%")
        print("   Network Efficiency: \(String(format: "%.1f", metrics.networkEfficiency * 100))%")
        print("   Error Rate: \(String(format: "%.3f", metrics.errorRate * 100))%")
    }
}

/// Advanced usage example
class AdvancedExampleUsage {
    
    static func runAdvancedExample() {
        let example = AdvancedAnalyticsExample()
        
        // Track user journey
        let journeySteps = ["landing_page", "product_browse", "add_to_cart", "checkout", "purchase"]
        example.trackUserJourney(userId: "user456", journeySteps: journeySteps)
        
        // Track e-commerce events
        let productData = [
            "id": "prod_123",
            "name": "iPhone 15 Pro",
            "price": 999.99,
            "category": "Electronics"
        ]
        example.trackEcommerceEvent(eventType: "purchase", productData: productData)
        
        // Track conversion funnel
        let funnelData = [
            "step_number": 3,
            "completion_rate": 0.75,
            "time_spent": 120.5
        ]
        example.trackConversionFunnel(userId: "user456", funnelName: "purchase_funnel", step: "checkout", stepData: funnelData)
        
        // Track user segmentation
        let segments = ["premium_user", "active_user", "mobile_user"]
        example.trackUserSegmentation(userId: "user456", segments: segments)
        
        // Track performance metrics
        let performanceData = [
            "cpu_usage": 25.5,
            "memory_usage": 150.2,
            "battery_level": 0.85,
            "network_speed": 50.0,
            "app_version": "1.2.3",
            "device_model": "iPhone 15 Pro"
        ]
        example.trackPerformanceMetrics(metrics: performanceData)
        
        // Batch track events
        let batchEvents = [
            ["name": "page_view", "page": "home", "duration": 30.5],
            ["name": "button_click", "button": "signup", "position": "header"],
            ["name": "form_submit", "form": "registration", "fields": 5]
        ]
        example.batchTrackEvents(events: batchEvents)
        
        // Track user behavior
        let behaviorData = [
            "type": "session_activity",
            "data": ["pages_visited": 8, "time_active": 900],
            "session_duration": 900.0,
            "interaction_count": 25
        ]
        example.trackUserBehavior(userId: "user456", behaviorPattern: behaviorData)
        
        // Track A/B test exposure
        example.trackABTestExposure(userId: "user456", testName: "new_ui_test", variant: "treatment")
        
        // Track predictive analytics
        let predictionData = [
            "confidence": 0.85,
            "model_version": "v2.1",
            "predicted_action": "purchase",
            "probability": 0.75
        ]
        example.trackPredictiveEvent(userId: "user456", predictionType: "purchase_prediction", predictionData: predictionData)
        
        // Get comprehensive metrics
        example.getComprehensiveMetrics()
    }
}

// MARK: - SwiftUI Integration Example

import SwiftUI

struct AdvancedAnalyticsView: View {
    @StateObject private var analytics = AdvancedAnalyticsExample()
    @State private var showingMetrics = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Advanced Analytics")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                ScrollView {
                    VStack(spacing: 15) {
                        AnalyticsButton("Track User Journey") {
                            analytics.trackUserJourney(userId: "user456", journeySteps: ["landing", "browse", "purchase"])
                        }
                        
                        AnalyticsButton("Track E-commerce") {
                            let productData = ["id": "prod_123", "name": "iPhone", "price": 999.99, "category": "Electronics"]
                            analytics.trackEcommerceEvent(eventType: "purchase", productData: productData)
                        }
                        
                        AnalyticsButton("Track Conversion Funnel") {
                            analytics.trackConversionFunnel(userId: "user456", funnelName: "purchase", step: "checkout", stepData: ["step": 3])
                        }
                        
                        AnalyticsButton("Track User Segmentation") {
                            analytics.trackUserSegmentation(userId: "user456", segments: ["premium", "active"])
                        }
                        
                        AnalyticsButton("Track Performance") {
                            let metrics = ["cpu_usage": 25.5, "memory_usage": 150.2, "battery_level": 0.85]
                            analytics.trackPerformanceMetrics(metrics: metrics)
                        }
                        
                        AnalyticsButton("Batch Track Events") {
                            let events = [
                                ["name": "page_view", "page": "home"],
                                ["name": "button_click", "button": "signup"]
                            ]
                            analytics.batchTrackEvents(events: events)
                        }
                        
                        AnalyticsButton("Track User Behavior") {
                            let behavior = ["type": "session", "data": ["pages": 8], "session_duration": 900.0, "interaction_count": 25]
                            analytics.trackUserBehavior(userId: "user456", behaviorPattern: behavior)
                        }
                        
                        AnalyticsButton("Track A/B Test") {
                            analytics.trackABTestExposure(userId: "user456", testName: "ui_test", variant: "treatment")
                        }
                        
                        AnalyticsButton("Track Predictive Analytics") {
                            let prediction = ["confidence": 0.85, "model_version": "v2.1", "predicted_action": "purchase", "probability": 0.75]
                            analytics.trackPredictiveEvent(userId: "user456", predictionType: "purchase_prediction", predictionData: prediction)
                        }
                        
                        AnalyticsButton("Get Metrics") {
                            showingMetrics = true
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Advanced Analytics")
            .sheet(isPresented: $showingMetrics) {
                MetricsView(analytics: analytics)
            }
        }
    }
}

struct AnalyticsButton: View {
    let title: String
    let action: () -> Void
    
    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(title) {
            action()
        }
        .buttonStyle(.borderedProminent)
        .frame(maxWidth: .infinity)
    }
}

struct MetricsView: View {
    let analytics: AdvancedAnalyticsExample
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Performance Metrics")
                    .font(.title)
                    .padding()
                
                // Metrics would be displayed here
                Text("Check console for detailed metrics")
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .navigationTitle("Metrics")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                analytics.getComprehensiveMetrics()
            }
        }
    }
}

#Preview {
    AdvancedAnalyticsView()
}
