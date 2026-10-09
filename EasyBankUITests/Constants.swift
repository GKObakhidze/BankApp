import Foundation

enum Constants {
    static let invalidEmail = "invalid-email"
    static let password = "Test123!"
    static let badlyFormattedError = "badly formatted"
    static let invalidCredentialsError = "malformed or has expired"

    static var uniqueEmail: String {
        "test_\(UUID().uuidString.prefix(8).lowercased())@easybank.test"
    }
}