//
//  EasyBankPage.swift
//  EasyBankUITests
//
//  Created by lmosakhlishvili on 10.02.25.
//

import XCTest

final class EasyBankPage {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }


    var onboardingLoginButton: XCUIElement { app.buttons["onboarding.login"] }
    var onboardingRegisterButton: XCUIElement { app.buttons["onboarding.register"] }


    var loginTitle: XCUIElement { app.staticTexts["Log In"] }
    var loginEmailField: XCUIElement { app.textFields["login.email"] }
    var loginPasswordField: XCUIElement { app.secureTextFields["login.password"] }
    var loginSubmitButton: XCUIElement { app.buttons["login.submit"] }
    var loginErrorText: XCUIElement { app.staticTexts["login.error"] }


    var registrationTitle: XCUIElement { app.staticTexts["Registration Form"] }
    var registrationEmailField: XCUIElement { app.textFields["registration.email"] }
    var registrationPasswordField: XCUIElement { app.secureTextFields["registration.password"] }
    var registrationRepeatPasswordField: XCUIElement { app.secureTextFields["registration.repeatPassword"] }
    var registrationSubmitButton: XCUIElement { app.buttons["registration.submit"] }
    var registrationErrorText: XCUIElement { app.staticTexts["registration.error"] }


    var strongPasswordCloseButton: XCUIElement { app.buttons["Close"] }
    var pasteMenuItem: XCUIElement { app.menuItems["Paste"] }


    var homeTabButton: XCUIElement { app.tabBars.buttons["Home"] }
    var sendMoneyButton: XCUIElement { app.buttons["home.sendMoney"] }
    var logoutButton: XCUIElement { app.navigationBars.buttons["home.logout"] }


    var logoutAlert: XCUIElement { app.alerts["Logging Out"] }
    var logoutConfirmButton: XCUIElement { logoutAlert.buttons["Yes"] }
}
