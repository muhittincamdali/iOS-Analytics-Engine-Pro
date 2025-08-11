import Foundation
import iOS-Analytics-Engine-Pro

/// Basic example demonstrating the core functionality of iOS-Analytics-Engine-Pro
@main
struct BasicExample {
    static func main() {
        print("🚀 iOS-Analytics-Engine-Pro Basic Example")
        
        // Initialize the framework
        let framework = iOS-Analytics-Engine-Pro()
        
        // Configure with default settings
        framework.configure()
        
        print("✅ Framework configured successfully")
        
        // Demonstrate basic functionality
        demonstrateBasicFeatures(framework)
    }
    
    static func demonstrateBasicFeatures(_ framework: iOS-Analytics-Engine-Pro) {
        print("\n📱 Demonstrating basic features...")
        
        // Add your example code here
        print("🎯 Feature 1: Core functionality")
        print("🎯 Feature 2: Configuration")
        print("🎯 Feature 3: Error handling")
        
        print("\n✨ Basic example completed successfully!")
    }
}
