import XCTest
@testable import AnalyticsEnginePro

class AnalyticsCoreTests: XCTestCase {
    var analytics: AnalyticsCore!
    
    override func setUp() {
        super.setUp()
        analytics = AnalyticsCore(configuration: .test)
    }
    
    override func tearDown() {
        analytics = nil
        super.tearDown()
    }
    
    func testEventTracking() {
        let expectation = XCTestExpectation(description: "Event tracked")
        
        analytics.track(event: "test_event") { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Event tracking failed: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testUserIdentification() {
        let expectation = XCTestExpectation(description: "User identified")
        
        analytics.identify(userId: "test_user", properties: ["name": "Test User"]) { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("User identification failed: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSessionManagement() {
        let expectation = XCTestExpectation(description: "Session started")
        
        analytics.startSession { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Session start failed: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testPerformanceMetrics() {
        let metrics = analytics.getPerformanceMetrics()
        
        XCTAssertGreaterThan(metrics.eventLatency, 0)
        XCTAssertGreaterThan(metrics.eventsPerSecond, 0)
        XCTAssertGreaterThan(metrics.memoryUsage, 0)
        XCTAssertGreaterThanOrEqual(metrics.batteryImpact, 0)
        XCTAssertGreaterThan(metrics.networkEfficiency, 0)
        XCTAssertGreaterThanOrEqual(metrics.errorRate, 0)
    }
    
    func testEventValidation() {
        let expectation = XCTestExpectation(description: "Invalid event rejected")
        
        analytics.track(event: "", properties: nil) { result in
            switch result {
            case .success:
                XCTFail("Empty event should be rejected")
            case .failure(let error):
                XCTAssertEqual(error, .invalidEvent)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testConfigurationValidation() {
        let config = AnalyticsConfiguration(apiKey: "test-key")
        
        XCTAssertEqual(config.apiKey, "test-key")
        XCTAssertEqual(config.environment, .production)
        XCTAssertTrue(config.realTimeTracking)
        XCTAssertTrue(config.predictiveAnalytics)
        XCTAssertTrue(config.abTesting)
        XCTAssertTrue(config.dataVisualization)
    }
    
    func testEncryptionTypes() {
        XCTAssertEqual(EncryptionType.aes256.rawValue, "aes256")
        XCTAssertEqual(EncryptionType.aes128.rawValue, "aes128")
        XCTAssertEqual(EncryptionType.none.rawValue, "none")
    }
    
    func testCompressionTypes() {
        XCTAssertEqual(CompressionType.gzip.rawValue, "gzip")
        XCTAssertEqual(CompressionType.deflate.rawValue, "deflate")
        XCTAssertEqual(CompressionType.none.rawValue, "none")
    }
    
    func testEnvironmentTypes() {
        XCTAssertEqual(AnalyticsEnvironment.development.rawValue, "development")
        XCTAssertEqual(AnalyticsEnvironment.staging.rawValue, "staging")
        XCTAssertEqual(AnalyticsEnvironment.production.rawValue, "production")
    }
    
    func testAnalyticsEventCreation() {
        let event = AnalyticsEvent(
            name: "test_event",
            properties: ["key": "value"],
            timestamp: Date(),
            sessionId: "session_123",
            userId: "user_456"
        )
        
        XCTAssertEqual(event.name, "test_event")
        XCTAssertEqual(event.properties["key"] as? String, "value")
        XCTAssertNotNil(event.timestamp)
        XCTAssertEqual(event.sessionId, "session_123")
        XCTAssertEqual(event.userId, "user_456")
    }
    
    func testErrorDescriptions() {
        let invalidEventError = AnalyticsError.invalidEvent
        XCTAssertEqual(invalidEventError.errorDescription, "Invalid analytics event")
        
        let networkError = AnalyticsError.networkError
        XCTAssertEqual(networkError.errorDescription, "Network communication error")
        
        let encryptionError = AnalyticsError.encryptionError
        XCTAssertEqual(encryptionError.errorDescription, "Data encryption error")
    }
}
