//
//  EasyBankPage.swift
//  EasyBankUITests
//

import XCTest

final class EasyBankPage {
    // Onboarding
    let onboardingLoginButton: XCUIElement
    let onboardingRegisterButton: XCUIElement

    // Login
    let loginEmailField: XCUIElement
    let loginPasswordField: XCUIElement
    let loginSubmitButton: XCUIElement
    let loginErrorText: XCUIElement

    // Registration
    let registrationEmailField: XCUIElement
    let registrationPasswordField: XCUIElement
    let registrationRepeatPasswordField: XCUIElement
    let registrationSubmitButton: XCUIElement
    let registrationErrorText: XCUIElement

    // The "Use Strong Password?" suggestion is drawn by iOS, not by the app, and only some
    // iOS versions show it. Close is the only button with that label on the registration form.
    let strongPasswordCloseButton: XCUIElement

    // Home
    let homeTabButton: XCUIElement
    let sendMoneyButton: XCUIElement
    let logoutButton: XCUIElement

    // Logout confirmation. Yes and No are plain labels, so they are scoped to the alert.
    let logoutAlert: XCUIElement
    let logoutConfirmButton: XCUIElement

    init(app: XCUIApplication) {
        onboardingLoginButton = app.buttons["onboarding.login"]
        onboardingRegisterButton = app.buttons["onboarding.register"]

        loginEmailField = app.textFields["login.email"]
        loginPasswordField = app.secureTextFields["login.password"]
        loginSubmitButton = app.buttons["login.submit"]
        loginErrorText = app.staticTexts["login.error"]

        registrationEmailField = app.textFields["registration.email"]
        registrationPasswordField = app.secureTextFields["registration.password"]
        registrationRepeatPasswordField = app.secureTextFields["registration.repeatPassword"]
        registrationSubmitButton = app.buttons["registration.submit"]
        registrationErrorText = app.staticTexts["registration.error"]

        strongPasswordCloseButton = app.buttons["Close"]

        homeTabButton = app.tabBars.buttons["Home"]
        sendMoneyButton = app.buttons["home.sendMoney"]
        logoutButton = app.buttons["home.logout"]

        logoutAlert = app.alerts["Logging Out"]
        logoutConfirmButton = logoutAlert.buttons["Yes"]
    }
}
