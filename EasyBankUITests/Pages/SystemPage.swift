//
//  SystemPage.swift
//  EasyBankUITests
//

import XCTest

final class SystemPage: BasePage {
    var strongPasswordCloseButton: XCUIElement { app.buttons[Constants.Label.strongPasswordClose] }
    var keyboardReturnKey: XCUIElement { app.keyboards.buttons[Constants.Label.keyboardReturn] }
}
