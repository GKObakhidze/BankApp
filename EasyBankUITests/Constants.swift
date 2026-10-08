//
//  Constants.swift
//  EasyBankUITests
//

import Foundation

struct Constants {

    // waiting times
    static let screenTimeout: TimeInterval = 10
    static let responseTimeout: TimeInterval = 15
    static let systemPromptTimeout: TimeInterval = 2

    // keyboard
    static let maxKeyboardSwitches = 6

    // test data
    static let invalidEmail = "invalid-email"
    static let unregisteredEmail = "not.registered.user@example.com"
    static let testPassword = "EasyBank#2026"
    static let emailPrefix = "easybank.user"
    static let emailDomain = "example.com"

    // expected error fragments
    static let badlyFormattedError = "badly formatted"
    static let invalidCredentialsError = "malformed or has expired"
}
