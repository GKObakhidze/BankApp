import Foundation

enum Constants {
    // Timeouts
    static let screenTimeout: TimeInterval = 10
    static let responseTimeout: TimeInterval = 15
    static let systemPromptTimeout: TimeInterval = 2

    // Test data
    static let invalidEmail = "invalid-email"
    static let invalidPassword = "invalid-password123"
    static let testPassword = "testPass123$"

    static func uniqueUnregisteredEmail() -> String {
        "unregistered-\(UUID().uuidString.lowercased())@example.com"
    }

    static func uniqueRegistrationEmail() -> String {
        "bankuser-\(UUID().uuidString.lowercased())@example.com"
    }

    // Expected error messages
    static let badlyFormattedError = "badly formatted"
    static let invalidCredentialsError = "malformed or has expired"
}