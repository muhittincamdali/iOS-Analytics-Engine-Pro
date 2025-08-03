import XCTest
@testable import AnalyticsEnginePro

class AnalyticsIntegrationTests: XCTestCase {
    var analytics: AnalyticsCore!
    
    override func setUp() {
        super.setUp()
        analytics = AnalyticsCore(configuration: .test)
    }
    
    override func tearDown() {
        analytics = nil
        super.tearDown()
    }
    
    func testCompleteUserJourney() {
        let expectation = XCTestExpectation(description: "Complete user journey")
        
        // Step 1: Start session
        analytics.startSession { result in
            XCTAssertTrue(result.isSuccess)
            
            // Step 2: Identify user
            self.analytics.identify(userId: "test_user", properties: ["name": "Test User"]) { result in
                XCTAssertTrue(result.isSuccess)
                
                // Step 3: Track events
                self.analytics.track(event: "page_view", properties: ["page": "home"]) { result in
                    XCTAssertTrue(result.isSuccess)
                    
                    // Step 4: Set user properties
                    self.analytics.setUserProperties(["premium": true]) { result in
                        XCTAssertTrue(result.isSuccess)
                        
                        // Step 5: End session
                        self.analytics.endSession { result in
                            XCTAssertTrue(result.isSuccess)
                            expectation.fulfill()
                        }
                    }
                }
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testHighVolumeEventTracking() {
        let expectation = XCTestExpectation(description: "High volume tracking")
        let eventCount = 100
        var completedEvents = 0
        
        for i in 0..<eventCount {
            analytics.track(event: "batch_event_\(i)", properties: ["index": i]) { result in
                XCTAssertTrue(result.isSuccess)
                completedEvents += 1
                
                if completedEvents == eventCount {
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testConcurrentEventTracking() {
        let expectation = XCTestExpectation(description: "Concurrent tracking")
        let concurrentCount = 10
        var completedEvents = 0
        
        DispatchQueue.concurrentPerform(iterations: concurrentCount) { index in
            analytics.track(event: "concurrent_event_\(index)") { result in
                XCTAssertTrue(result.isSuccess)
                completedEvents += 1
                
                if completedEvents == concurrentCount {
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testErrorHandlingAndRecovery() {
        let expectation = XCTestExpectation(description: "Error handling")
        
        // Test with invalid configuration
        let invalidConfig = AnalyticsConfiguration(apiKey: "")
        let invalidAnalytics = AnalyticsCore(configuration: invalidConfig)
        
        invalidAnalytics.track(event: "test_event") { result in
            switch result {
            case .success:
                XCTFail("Should fail with invalid configuration")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDataPersistenceAndRecovery() {
        let expectation = XCTestExpectation(description: "Data persistence")
        
        // Track events
        analytics.track(event: "persistence_test") { result in
            XCTAssertTrue(result.isSuccess)
            
            // Flush events
            self.analytics.flush { result in
                XCTAssertTrue(result.isSuccess)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPerformanceUnderLoad() {
        let expectation = XCTestExpectation(description: "Performance test")
        let startTime = Date()
        
        analytics.track(event: "performance_test") { result in
            XCTAssertTrue(result.isSuccess)
            
            let endTime = Date()
            let duration = endTime.timeIntervalSince(startTime)
            
            // Should complete within 1 second
            XCTAssertLessThan(duration, 1.0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testMemoryUsage() {
        let expectation = XCTestExpectation(description: "Memory usage test")
        
        // Track multiple events to test memory usage
        for i in 0..<50 {
            analytics.track(event: "memory_test_\(i)", properties: ["data": "test_data_\(i)"]) { result in
                XCTAssertTrue(result.isSuccess)
                
                if i == 49 {
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    func testNetworkResilience() {
        let expectation = XCTestExpectation(description: "Network resilience")
        
        // Simulate network issues by tracking events rapidly
        DispatchQueue.global(qos: .background).async {
            for i in 0..<20 {
                self.analytics.track(event: "network_test_\(i)") { result in
                    XCTAssertTrue(result.isSuccess)
                    
                    if i == 19 {
                        expectation.fulfill()
                    }
                }
                
                Thread.sleep(forTimeInterval: 0.1)
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
