//
//  PageClasss.swift
//  EasyBankUITests
//
//  Created by lmosakhlishvili on 10.02.25.
//
import XCTest

class EasyBankPage {
    let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    // MARK: - Onboarding Screen
    var onboardingLoginButton: XCUIElement {
        app.buttons["onboarding.login"]
    }

    var onboardingRegisterButton: XCUIElement {
        app.buttons["onboarding.register"]
    }

    // MARK: - Login Screen
    var loginEmailTextField: XCUIElement {
        app.textFields["login.email"]
    }

    var loginPasswordTextField: XCUIElement {
        app.secureTextFields["login.password"]
    }

    var loginSubmitButton: XCUIElement {
        app.buttons["login.submit"]
    }

    var loginRegisterButton: XCUIElement {
        app.buttons["login.register"]
    }

    var loginErrorLabel: XCUIElement {
        app.staticTexts["login.error"]
    }

    // MARK: - Registration Screen
    var registrationEmailTextField: XCUIElement {
        app.textFields["registration.email"]
    }

    var registrationPasswordTextField: XCUIElement {
        app.secureTextFields["registration.password"]
    }

    var registrationRepeatPasswordTextField: XCUIElement {
        app.secureTextFields["registration.repeatPassword"]
    }

    var registrationSubmitButton: XCUIElement {
        app.buttons["registration.submit"]
    }

    var registrationLoginButton: XCUIElement {
        app.buttons["registration.login"]
    }

    var registrationErrorLabel: XCUIElement {
        app.staticTexts["registration.error"]
    }

    // MARK: - Home Screen
    var homeSendMoneyButton: XCUIElement {
        app.buttons["home.sendMoney"]
    }

    var homeLogoutButton: XCUIElement {
        app.buttons["home.logout"]
    }

    var homeTabButton: XCUIElement {
        app.tabBars.buttons["Home"]
    }

    // MARK: - Logout Alert
    var logoutAlert: XCUIElement {
        app.alerts["Logging Out"]
    }

    var logoutConfirmButton: XCUIElement {
        logoutAlert.buttons["Yes"]
    }

    var logoutCancelButton: XCUIElement {
        logoutAlert.buttons["No"]
    }
}
