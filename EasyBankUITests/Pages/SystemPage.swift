//
//  SystemPage.swift
//  EasyBankUITests
//

import XCTest

final class SystemPage: BasePage {
    var keyboardReturnKey: XCUIElement { app.keyboards.buttons[Constants.Label.keyboardReturn] }
}
