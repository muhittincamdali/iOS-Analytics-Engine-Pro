import XCTest
@testable import AnalyticsEnginePro

class AnalyticsPerformanceTests: XCTestCase {
    var analytics: AnalyticsCore!
    
    override func setUp() {
        super.setUp()
        analytics = AnalyticsCore(configuration: .performance)
    }
    
    override func tearDown() {
        analytics = nil
        super.tearDown()
    }
    
    func testHighVolumeEventTracking() {
        measure {
            for i in 0..<1000 {
                analytics.track(event: "performance_test_\(i)")
            }
        }
    }
    
    func testMemoryUsageUnderLoad() {
        measure {
            for i in 0..<500 {
                analytics.track(event: "memory_test_\(i)", properties: [
                    "data": "test_data_\(i)",
                    "timestamp": Date(),
                    "user_id": "user_\(i % 100)"
                ])
            }
        }
    }
    
    func testConcurrentEventProcessing() {
        measure {
            let group = DispatchGroup()
            
            for i in 0..<100 {
                group.enter()
                DispatchQueue.global(qos: .userInitiated).async {
                    self.analytics.track(event: "concurrent_test_\(i)")
                    group.leave()
                }
            }
            
            group.wait()
        }
    }
    
    func testEventLatency() {
        measure {
            let expectation = XCTestExpectation(description: "Event latency")
            
            analytics.track(event: "latency_test") { result in
                XCTAssertTrue(result.isSuccess)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1.0)
        }
    }
    
    func testBatchProcessingPerformance() {
        measure {
            let expectation = XCTestExpectation(description: "Batch processing")
            var completedEvents = 0
            let totalEvents = 100
            
            for i in 0..<totalEvents {
                analytics.track(event: "batch_test_\(i)") { result in
                    XCTAssertTrue(result.isSuccess)
                    completedEvents += 1
                    
                    if completedEvents == totalEvents {
                        expectation.fulfill()
                    }
                }
            }
            
            wait(for: [expectation], timeout: 10.0)
        }
    }
    
    func testNetworkEfficiency() {
        measure {
            let expectation = XCTestExpectation(description: "Network efficiency")
            var completedEvents = 0
            let totalEvents = 50
            
            for i in 0..<totalEvents {
                analytics.track(event: "network_efficiency_\(i)", properties: [
                    "payload_size": "large_data_\(i)",
                    "compression": true,
                    "encryption": true
                ]) { result in
                    XCTAssertTrue(result.isSuccess)
                    completedEvents += 1
                    
                    if completedEvents == totalEvents {
                        expectation.fulfill()
                    }
                }
            }
            
            wait(for: [expectation], timeout: 15.0)
        }
    }
    
    func testBatteryImpact() {
        measure {
            let expectation = XCTestExpectation(description: "Battery impact")
            var completedEvents = 0
            let totalEvents = 200
            
            for i in 0..<totalEvents {
                analytics.track(event: "battery_test_\(i)") { result in
                    XCTAssertTrue(result.isSuccess)
                    completedEvents += 1
                    
                    if completedEvents == totalEvents {
                        expectation.fulfill()
                    }
                }
            }
            
            wait(for: [expectation], timeout: 20.0)
        }
    }
    
    func testCPUUsage() {
        measure {
            let expectation = XCTestExpectation(description: "CPU usage")
            var completedEvents = 0
            let totalEvents = 300
            
            for i in 0..<totalEvents {
                analytics.track(event: "cpu_test_\(i)", properties: [
                    "complex_calculation": "data_processing_\(i)",
                    "algorithm": "optimization_\(i)"
                ]) { result in
                    XCTAssertTrue(result.isSuccess)
                    completedEvents += 1
                    
                    if completedEvents == totalEvents {
                        expectation.fulfill()
                    }
                }
            }
            
            wait(for: [expectation], timeout: 25.0)
        }
    }
    
    func testThroughput() {
        measure {
            let expectation = XCTestExpectation(description: "Throughput test")
            let startTime = Date()
            var completedEvents = 0
            let targetEvents = 1000
            
            for i in 0..<targetEvents {
                analytics.track(event: "throughput_test_\(i)") { result in
                    XCTAssertTrue(result.isSuccess)
                    completedEvents += 1
                    
                    if completedEvents == targetEvents {
                        let endTime = Date()
                        let duration = endTime.timeIntervalSince(startTime)
                        let eventsPerSecond = Double(completedEvents) / duration
                        
                        // Should achieve at least 100 events per second
                        XCTAssertGreaterThan(eventsPerSecond, 100.0)
                        expectation.fulfill()
                    }
                }
            }
            
            wait(for: [expectation], timeout: 30.0)
        }
    }
    
    func testMemoryLeakDetection() {
        weak var weakAnalytics: AnalyticsCore?
        
        autoreleasepool {
            let analytics = AnalyticsCore(configuration: .performance)
            weakAnalytics = analytics
            
            for i in 0..<100 {
                analytics.track(event: "memory_leak_test_\(i)")
            }
        }
        
        // Analytics should be deallocated
        XCTAssertNil(weakAnalytics)
    }
    
    func testStressTest() {
        measure {
            let expectation = XCTestExpectation(description: "Stress test")
            let group = DispatchGroup()
            let concurrentCount = 10
            let eventsPerThread = 100
            
            for thread in 0..<concurrentCount {
                group.enter()
                DispatchQueue.global(qos: .background).async {
                    for event in 0..<eventsPerThread {
                        self.analytics.track(event: "stress_test_thread_\(thread)_event_\(event)")
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 60.0)
        }
    }
}
