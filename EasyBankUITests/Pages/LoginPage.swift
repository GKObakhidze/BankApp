//
//  LoginPage.swift
//  EasyBankUITests
//

import XCTest

final class LoginPage: BasePage {
    var emailField: XCUIElement { app.textFields[Constants.Identifier.loginEmail] }
    var passwordField: XCUIElement { app.secureTextFields[Constants.Identifier.loginPassword] }
    var submitButton: XCUIElement { app.buttons[Constants.Identifier.loginSubmit] }
    var errorLabel: XCUIElement { app.staticTexts[Constants.Identifier.loginError] }
}
