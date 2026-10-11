//
//  Constants.swift
//  EasyBankUITests
//

import Foundation

enum Constants {
    enum Timeout {
        static let element: TimeInterval = 10
    }

    enum Label {
        static let homeTab = "Home"
        static let logoutAlertTitle = "Logging Out"
        static let logoutConfirm = "Yes"
        static let passwordVisibilityToggle = "hide"
        static let keyboardReturn = "Return"
    }

    enum ErrorText {
        static let badlyFormattedEmail = "badly formatted"
        static let malformedOrExpired = "malformed or has expired"
    }

    enum TestData {
        static let validPassword = "Str0ngPass!42"
        static let invalidEmail = "invalid-email"
        static let emailPrefix = "easybank."
        static let emailDomain = "@example.com"
    }
}
