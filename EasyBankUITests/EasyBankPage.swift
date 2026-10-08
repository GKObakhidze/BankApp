//
//  EasyBankPage.swift
//  EasyBankUITests
//
//  Created by lmosakhlishvili on 10.02.25.
//

import XCTest

class EasyBankPage {

    // onboarding
    let onboardingLoginButton: XCUIElement
    let onboardingRegisterButton: XCUIElement

    // login form
    let loginEmailField: XCUIElement
    let loginPasswordField: XCUIElement
    let loginSubmitButton: XCUIElement
    let loginError: XCUIElement

    // registration form
    let registrationEmailField: XCUIElement
    let registrationPasswordField: XCUIElement
    let registrationRepeatPasswordField: XCUIElement
    let registrationSubmitButton: XCUIElement

    // system keyboard and "Use Strong Password?" prompt
    let keyboard: XCUIElement
    let strongPasswordCloseButton: XCUIElement

    // home
    let homeTab: XCUIElement
    let sendMoneyButton: XCUIElement
    let logoutButton: XCUIElement

    // logout confirmation
    let logoutAlert: XCUIElement
    let logoutConfirmButton: XCUIElement

    init(app: XCUIApplication) {
        onboardingLoginButton = app.buttons["onboarding.login"]
        onboardingRegisterButton = app.buttons["onboarding.register"]

        loginEmailField = app.textFields["login.email"]
        loginPasswordField = app.secureTextFields["login.password"]
        loginSubmitButton = app.buttons["login.submit"]
        loginError = app.staticTexts["login.error"]

        registrationEmailField = app.textFields["registration.email"]
        registrationPasswordField = app.secureTextFields["registration.password"]
        registrationRepeatPasswordField = app.secureTextFields["registration.repeatPassword"]
        registrationSubmitButton = app.buttons["registration.submit"]

        keyboard = app.keyboards.firstMatch
        strongPasswordCloseButton = app.buttons["Close"]

        homeTab = app.tabBars.buttons["Home"]
        sendMoneyButton = app.buttons["home.sendMoney"]
        logoutButton = app.buttons["home.logout"]

        logoutAlert = app.alerts["Logging Out"]
        logoutConfirmButton = logoutAlert.buttons["Yes"]
    }
}
