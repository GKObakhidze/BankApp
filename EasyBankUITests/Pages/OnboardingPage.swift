//
//  OnboardingPage.swift
//  EasyBankUITests
//

import XCTest

final class OnboardingPage: BasePage {
    var loginButton: XCUIElement { app.buttons["onboarding.login"] }
    var registerButton: XCUIElement { app.buttons["onboarding.register"] }
}
