//
//  EasyBankConstants.swift
//  EasyBankUITests
//

import Foundation

enum EasyBankConstants {
    enum Timeout {
        static let element: TimeInterval = 15
        static let optionalPrompt: TimeInterval = 2
    }

    enum Credentials {
        static let invalidFormatEmail = "invalid-email"
        static let password = "Test1234!Pass"
        static let emailDomain = "example.com"
        static let registeredEmailPrefix = "user"
        static let unregisteredEmailPrefix = "ghost"
    }

    enum ErrorFragment {
        static let badlyFormattedEmail = "badly formatted"
        static let invalidCredentials = "malformed or has expired"
    }
}
