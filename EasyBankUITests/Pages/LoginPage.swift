//
//  LoginPage.swift
//  EasyBankUITests
//

import XCTest

final class LoginPage: BasePage {
    var emailField: XCUIElement { app.textFields["login.email"] }
    var passwordField: XCUIElement { app.secureTextFields["login.password"] }
    var submitButton: XCUIElement { app.buttons["login.submit"] }
    var errorLabel: XCUIElement { app.staticTexts["login.error"] }
}
