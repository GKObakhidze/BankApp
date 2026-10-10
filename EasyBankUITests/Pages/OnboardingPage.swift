//
//  OnboardingPage.swift
//  EasyBankUITests
//

import XCTest

final class OnboardingPage: BasePage {
    var loginButton: XCUIElement { app.buttons[Constants.Identifier.onboardingLogin] }
    var registerButton: XCUIElement { app.buttons[Constants.Identifier.onboardingRegister] }
}
