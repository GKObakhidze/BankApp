//
//  RegistrationPage.swift
//  EasyBankUITests
//

import XCTest

final class RegistrationPage: BasePage {
    var emailField: XCUIElement { app.textFields[Constants.Identifier.registrationEmail] }
    var submitButton: XCUIElement { app.buttons[Constants.Identifier.registrationSubmit] }

    var securePasswordField: XCUIElement { app.secureTextFields[Constants.Identifier.registrationPassword] }
    var plainPasswordField: XCUIElement { app.textFields[Constants.Identifier.registrationPassword] }
    var passwordVisibilityToggle: XCUIElement { securePasswordField.buttons[Constants.Label.passwordVisibilityToggle] }

    var secureRepeatPasswordField: XCUIElement { app.secureTextFields[Constants.Identifier.registrationRepeatPassword] }
    var plainRepeatPasswordField: XCUIElement { app.textFields[Constants.Identifier.registrationRepeatPassword] }
    var repeatPasswordVisibilityToggle: XCUIElement { secureRepeatPasswordField.buttons[Constants.Label.passwordVisibilityToggle] }
}
