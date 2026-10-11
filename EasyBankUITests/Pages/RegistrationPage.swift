//
//  RegistrationPage.swift
//  EasyBankUITests
//

import XCTest

final class RegistrationPage: BasePage {
    var emailField: XCUIElement { app.textFields["registration.email"] }
    var submitButton: XCUIElement { app.buttons["registration.submit"] }

    var securePasswordField: XCUIElement { app.secureTextFields["registration.password"] }
    var plainPasswordField: XCUIElement { app.textFields["registration.password"] }
    var passwordVisibilityToggle: XCUIElement { securePasswordField.buttons[Constants.Label.passwordVisibilityToggle] }

    var secureRepeatPasswordField: XCUIElement { app.secureTextFields["registration.repeatPassword"] }
    var plainRepeatPasswordField: XCUIElement { app.textFields["registration.repeatPassword"] }
    var repeatPasswordVisibilityToggle: XCUIElement { secureRepeatPasswordField.buttons[Constants.Label.passwordVisibilityToggle] }
}
