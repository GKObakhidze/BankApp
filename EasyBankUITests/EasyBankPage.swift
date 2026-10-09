//
//  EasyBankPage.swift
//  EasyBankUITests
//
//  Element locators only. No actions, no waits, no assertions.
//

import XCTest

final class EasyBankPage {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    // MARK: - Onboarding

    var onboardingLoginButton: XCUIElement { app.buttons["onboarding.login"] }
    var onboardingRegisterButton: XCUIElement { app.buttons["onboarding.register"] }

    // MARK: - Login

    var loginEmailField: XCUIElement { app.textFields["login.email"] }
    var loginPasswordField: XCUIElement { app.secureTextFields["login.password"] }
    var loginSubmitButton: XCUIElement { app.buttons["login.submit"] }
    var loginRegisterButton: XCUIElement { app.buttons["login.register"] }
    var loginErrorLabel: XCUIElement { app.staticTexts["login.error"] }

    // MARK: - Registration

    var registrationEmailField: XCUIElement { app.textFields["registration.email"] }
    var registrationPasswordField: XCUIElement { app.secureTextFields["registration.password"] }
    var registrationRepeatPasswordField: XCUIElement { app.secureTextFields["registration.repeatPassword"] }
    var registrationSubmitButton: XCUIElement { app.buttons["registration.submit"] }
    var registrationLoginButton: XCUIElement { app.buttons["registration.login"] }
    var registrationErrorLabel: XCUIElement { app.staticTexts["registration.error"] }

    // MARK: - Home

    var homeTab: XCUIElement { app.tabBars.buttons["Home"] }
    var homeSendMoneyButton: XCUIElement { app.buttons["home.sendMoney"] }
    var homeLogoutButton: XCUIElement { app.buttons["home.logout"] }

    // MARK: - Logout confirmation alert

    var logoutAlert: XCUIElement { app.alerts["Logging Out"] }
    var logoutConfirmButton: XCUIElement { logoutAlert.buttons["Yes"] }
    var logoutCancelButton: XCUIElement { logoutAlert.buttons["No"] }

    // MARK: - Keyboard

    var keyboard: XCUIElement { app.keyboards.element }
    var keyboardReturnKey: XCUIElement { app.keyboards.buttons["return"] }

    // MARK: - System "Use Strong Password?" prompt (SpringBoard, not an app element)

    private var springboard: XCUIApplication {
        XCUIApplication(bundleIdentifier: "com.apple.springboard")
    }

    /// Labels the dismiss control of the strong-password prompt can carry across iOS versions.
    var strongPasswordDismissLabels: [String] {
        ["Close", "Not Now", "Choose My Own Password", "Use Custom Password"]
    }

    func strongPasswordDismissButton(labeled label: String) -> XCUIElement {
        springboard.buttons[label]
    }
}
