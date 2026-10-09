//
//  EasyBankPage.swift
//  EasyBankUITests
//
//  Created by lmosakhlishvili on 10.02.25.
//

import XCTest

final class EasyBankPage {
    private let app = XCUIApplication()
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

    // MARK: - Onboarding
    var onboardingLoginButton: XCUIElement { app.buttons["onboarding.login"] }
    var onboardingRegisterButton: XCUIElement { app.buttons["onboarding.register"] }

    // MARK: - Login
    var loginEmailField: XCUIElement { app.textFields["login.email"] }
    var loginPasswordField: XCUIElement { app.secureTextFields["login.password"] }
    var loginSubmitButton: XCUIElement { app.buttons["login.submit"] }
    var loginErrorMessage: XCUIElement { app.staticTexts["login.error"] }

    // MARK: - Registration
    var registrationEmailField: XCUIElement { app.textFields["registration.email"] }
    var registrationPasswordField: XCUIElement { app.secureTextFields["registration.password"] }
    var registrationRepeatPasswordField: XCUIElement { app.secureTextFields["registration.repeatPassword"] }
    var registrationSubmitButton: XCUIElement { app.buttons["registration.submit"] }

    // System "Use Strong Password?" prompt; depending on the iOS version it belongs to the app or to SpringBoard.
    var strongPasswordCloseButton: XCUIElement { app.buttons["Close"] }
    var systemStrongPasswordCloseButton: XCUIElement { springboard.buttons["Close"] }

    // MARK: - Home
    var homeTab: XCUIElement { app.tabBars.buttons["Home"] }
    var sendMoneyButton: XCUIElement { app.buttons["home.sendMoney"] }
    var logoutButton: XCUIElement { app.buttons["home.logout"] }

    // MARK: - Logout confirmation
    var logoutAlert: XCUIElement { app.alerts["Logging Out"] }
    var logoutConfirmButton: XCUIElement { logoutAlert.buttons["Yes"] }
}
