//
//  RegistrationPage.swift
//  EasyBankUITests
//

import XCTest

final class RegistrationPage: BasePage {
    var emailField: XCUIElement { app.textFields[Constants.Identifier.registrationEmail] }
    var passwordField: XCUIElement { app.secureTextFields[Constants.Identifier.registrationPassword] }
    var repeatPasswordField: XCUIElement { app.secureTextFields[Constants.Identifier.registrationRepeatPassword] }
    var submitButton: XCUIElement { app.buttons[Constants.Identifier.registrationSubmit] }
}
