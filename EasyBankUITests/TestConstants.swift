import Foundation

enum Timeout {
    static let short: TimeInterval = 1
    static let medium: TimeInterval = 5
    static let standard: TimeInterval = 10
    static let long: TimeInterval = 15
}

enum TestData {
    static let password = "Test123!"
    static let invalidEmail = "invalid-email"

    static func uniqueEmail(prefix: String) -> String {
        "\(prefix)-\(UUID().uuidString.prefix(8).lowercased())@example.com"
    }
}

enum ErrorText {
    static let badlyFormatted = "badly formatted"
    static let invalidCredentials = "malformed or has expired"
}

enum FailureMessage {
    static let fieldNotFound = "Field not found"
    static let errorNotShown = "Error message not shown"
    static let mainScreenNotDisplayed = "Main screen not displayed"

    static func wrongError(expected: String, actual: String) -> String {
        "Expected '\(expected)' but got '\(actual)'"
    }
}