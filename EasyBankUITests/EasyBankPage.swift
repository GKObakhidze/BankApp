//
//  EasyBankPage.swift
//  EasyBankUITests
//
//  Created by lmosakhlishvili on 10.02.25.
//

import XCTest

final class EasyBankPage {
    private let app = XCUIApplication()

    var onboardingLoginButton: XCUIElement { app.buttons["onboarding.login"] }
    var onboardingRegisterButton: XCUIElement { app.buttons["onboarding.register"] }

    var loginEmailField: XCUIElement { app.textFields["login.email"] }
    var loginPasswordField: XCUIElement { app.secureTextFields["login.password"] }
    var loginSubmitButton: XCUIElement { app.buttons["login.submit"] }
    var loginErrorMessage: XCUIElement { app.staticTexts["login.error"] }

    var registrationEmailField: XCUIElement { app.textFields["registration.email"] }
    var registrationPasswordVisibilityToggle: XCUIElement { app.secureTextFields["registration.password"].buttons["hide"] }
    var registrationRepeatPasswordVisibilityToggle: XCUIElement { app.secureTextFields["registration.repeatPassword"].buttons["hide"] }
    var registrationVisiblePasswordField: XCUIElement { app.textFields["registration.password"] }
    var registrationVisibleRepeatPasswordField: XCUIElement { app.textFields["registration.repeatPassword"] }
    var registrationSubmitButton: XCUIElement { app.buttons["registration.submit"] }

    var homeTab: XCUIElement { app.tabBars.buttons["Home"] }
    var sendMoneyButton: XCUIElement { app.buttons["home.sendMoney"] }
    var logoutButton: XCUIElement { app.buttons["home.logout"] }

    var logoutAlert: XCUIElement { app.alerts["Logging Out"] }
    var logoutConfirmButton: XCUIElement { logoutAlert.buttons["Yes"] }
}
