//
//  TestData.swift
//  EasyBankUITests
//

import Foundation

enum TestData {
    static let invalidEmail = "invalid-email"
    static let password = "Password123"
    static let strongPassword = "StrongPass123!"

    static let invalidEmailErrorFragment = "badly formatted"
    static let invalidCredentialsErrorFragment = "malformed or has expired"

    static func uniqueEmail() -> String {
        "uitest.\(UUID().uuidString.prefix(8).lowercased())@example.com"
    }
}
