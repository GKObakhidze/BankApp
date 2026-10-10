//
//  EasyBankPage.swift
//  EasyBankUITests
//

import XCTest

/// Page: only element locators and queries.
/// No taps, typing, waits or assertions here - those live in EasyBankSteps.
final class EasyBankPage {
    private let app: XCUIApplication
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

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
    var loginErrorLabel: XCUIElement { app.staticTexts["login.error"] }

    // MARK: - Registration

    var registrationEmailField: XCUIElement { app.textFields["registration.email"] }
    var registrationPasswordField: XCUIElement { app.secureTextFields["registration.password"] }
    var registrationRepeatPasswordField: XCUIElement { app.secureTextFields["registration.repeatPassword"] }
    var registrationSubmitButton: XCUIElement { app.buttons["registration.submit"] }
    var registrationErrorLabel: XCUIElement { app.staticTexts["registration.error"] }

    // MARK: - Home

    var homeTabButton: XCUIElement { app.tabBars.buttons["Home"] }
    var sendMoneyButton: XCUIElement { app.buttons["home.sendMoney"] }
    var logoutButton: XCUIElement { app.buttons["home.logout"] }

    // MARK: - Logout confirmation alert

    var logoutAlert: XCUIElement { app.alerts["Logging Out"] }
    var logoutConfirmButton: XCUIElement { logoutAlert.buttons["Yes"] }

    // MARK: - System UI (keyboard and iOS password prompts)

    var keyboard: XCUIElement { app.keyboards.firstMatch }

    /// "Use Strong Password?" prompt - the dismiss button label can differ between iOS versions.
    var strongPasswordDismissButtons: [XCUIElement] {
        ["Close", "Choose My Own Password"].flatMap { label in
            [app.buttons[label], springboard.buttons[label]]
        }
    }

    /// "Save Password?" prompt that iOS may show after registration or login.
    var savePasswordNotNowButtons: [XCUIElement] {
        [app.buttons["Not Now"], springboard.buttons["Not Now"]]
    }
}
