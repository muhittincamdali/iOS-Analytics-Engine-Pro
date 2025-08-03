import AnalyticsEnginePro

/// Basic example demonstrating core analytics functionality
/// This example shows how to initialize the analytics engine
/// and track basic events for a simple iOS application.
class BasicAnalyticsExample {
    
    private let analytics: AnalyticsCore
    
    init() {
        // Initialize analytics with basic configuration
        let config = AnalyticsConfiguration(
            apiKey: "your-api-key-here",
            environment: .development,
            realTimeTracking: true,
            predictiveAnalytics: false,
            abTesting: false,
            dataVisualization: false,
            autoStartSession: true,
            debugLogging: true
        )
        
        self.analytics = AnalyticsCore(configuration: config)
    }
    
    /// Track user login event
    func trackUserLogin(userId: String, loginMethod: String) {
        analytics.track(event: "user_login", properties: [
            "user_id": userId,
            "login_method": loginMethod,
            "timestamp": Date()
        ]) { result in
            switch result {
            case .success:
                print("✅ User login tracked successfully")
            case .failure(let error):
                print("❌ Failed to track user login: \(error)")
            }
        }
    }
    
    /// Track page view event
    func trackPageView(pageName: String, pageCategory: String) {
        analytics.track(event: "page_view", properties: [
            "page_name": pageName,
            "page_category": pageCategory,
            "session_duration": analytics.getPerformanceMetrics().eventLatency
        ]) { result in
            switch result {
            case .success:
                print("✅ Page view tracked successfully")
            case .failure(let error):
                print("❌ Failed to track page view: \(error)")
            }
        }
    }
    
    /// Track user action event
    func trackUserAction(actionName: String, actionValue: String) {
        analytics.track(event: "user_action", properties: [
            "action_name": actionName,
            "action_value": actionValue,
            "device_type": "iOS"
        ]) { result in
            switch result {
            case .success:
                print("✅ User action tracked successfully")
            case .failure(let error):
                print("❌ Failed to track user action: \(error)")
            }
        }
    }
    
    /// Identify user with properties
    func identifyUser(userId: String, userProperties: [String: Any]) {
        analytics.identify(userId: userId, properties: userProperties) { result in
            switch result {
            case .success:
                print("✅ User identified successfully")
            case .failure(let error):
                print("❌ Failed to identify user: \(error)")
            }
        }
    }
    
    /// Set user properties
    func setUserProperties(_ properties: [String: Any]) {
        analytics.setUserProperties(properties) { result in
            switch result {
            case .success:
                print("✅ User properties set successfully")
            case .failure(let error):
                print("❌ Failed to set user properties: \(error)")
            }
        }
    }
    
    /// Start user session
    func startUserSession() {
        analytics.startSession { result in
            switch result {
            case .success:
                print("✅ User session started successfully")
            case .failure(let error):
                print("❌ Failed to start user session: \(error)")
            }
        }
    }
    
    /// End user session
    func endUserSession() {
        analytics.endSession { result in
            switch result {
            case .success:
                print("✅ User session ended successfully")
            case .failure(let error):
                print("❌ Failed to end user session: \(error)")
            }
        }
    }
    
    /// Get performance metrics
    func getPerformanceMetrics() {
        let metrics = analytics.getPerformanceMetrics()
        print("📊 Performance Metrics:")
        print("   Event Latency: \(metrics.eventLatency)s")
        print("   Events Per Second: \(metrics.eventsPerSecond)")
        print("   Memory Usage: \(metrics.memoryUsage / 1024 / 1024)MB")
        print("   Battery Impact: \(metrics.batteryImpact * 100)%")
        print("   Network Efficiency: \(metrics.networkEfficiency * 100)%")
        print("   Error Rate: \(metrics.errorRate * 100)%")
    }
    
    /// Flush pending events
    func flushEvents() {
        analytics.flush { result in
            switch result {
            case .success:
                print("✅ Events flushed successfully")
            case .failure(let error):
                print("❌ Failed to flush events: \(error)")
            }
        }
    }
}

/// Usage example
class BasicExampleUsage {
    
    static func runExample() {
        let example = BasicAnalyticsExample()
        
        // Start session
        example.startUserSession()
        
        // Identify user
        example.identifyUser(userId: "user123", userProperties: [
            "name": "John Doe",
            "email": "john@example.com",
            "plan": "premium"
        ])
        
        // Track user login
        example.trackUserLogin(userId: "user123", loginMethod: "email")
        
        // Track page views
        example.trackPageView(pageName: "Home", pageCategory: "main")
        example.trackPageView(pageName: "Products", pageCategory: "catalog")
        
        // Track user actions
        example.trackUserAction(actionName: "button_click", actionValue: "add_to_cart")
        example.trackUserAction(actionName: "search", actionValue: "iphone")
        
        // Set additional user properties
        example.setUserProperties([
            "last_login": Date(),
            "preferences": ["theme": "dark", "language": "en"]
        ])
        
        // Get performance metrics
        example.getPerformanceMetrics()
        
        // Flush events
        example.flushEvents()
        
        // End session
        example.endUserSession()
    }
}

// MARK: - SwiftUI Integration Example

import SwiftUI

struct BasicAnalyticsView: View {
    @StateObject private var analytics = BasicAnalyticsExample()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Analytics Engine Pro")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button("Track Login") {
                analytics.trackUserLogin(userId: "user123", loginMethod: "email")
            }
            .buttonStyle(.borderedProminent)
            
            Button("Track Page View") {
                analytics.trackPageView(pageName: "Home", pageCategory: "main")
            }
            .buttonStyle(.bordered)
            
            Button("Track User Action") {
                analytics.trackUserAction(actionName: "button_click", actionValue: "test_action")
            }
            .buttonStyle(.bordered)
            
            Button("Get Metrics") {
                analytics.getPerformanceMetrics()
            }
            .buttonStyle(.bordered)
            
            Button("Flush Events") {
                analytics.flushEvents()
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .onAppear {
            analytics.startUserSession()
        }
        .onDisappear {
            analytics.endUserSession()
        }
    }
}

#Preview {
    BasicAnalyticsView()
}
