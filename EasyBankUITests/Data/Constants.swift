//
//  Constants.swift
//  EasyBankUITests
//

import Foundation

enum Constants {
    enum Timeout {
        static let element: TimeInterval = 10
        static let systemPrompt: TimeInterval = 2
    }

    enum Identifier {
        static let onboardingLogin = "onboarding.login"
        static let onboardingRegister = "onboarding.register"

        static let loginEmail = "login.email"
        static let loginPassword = "login.password"
        static let loginSubmit = "login.submit"
        static let loginError = "login.error"

        static let registrationEmail = "registration.email"
        static let registrationPassword = "registration.password"
        static let registrationRepeatPassword = "registration.repeatPassword"
        static let registrationSubmit = "registration.submit"

        static let homeSendMoney = "home.sendMoney"
        static let homeLogout = "home.logout"
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
        static let emailDomain = "example.com"

        static func uniqueEmail() -> String {
            "easybank.\(UUID().uuidString.prefix(8).lowercased())@\(emailDomain)"
        }
    }
}
