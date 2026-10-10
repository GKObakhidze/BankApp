//
//  BaseSteps.swift
//  EasyBankUITests
//

import XCTest

class BaseSteps {
    let app: XCUIApplication
    let page: EasyBankPage
    let timeout = Constants.Timeout.element

    init(app: XCUIApplication) {
        self.app = app
        page = EasyBankPage(app: app)
    }

    func tap(_ element: XCUIElement) {
        XCTAssertTrue(element.waitForExistence(timeout: timeout), "Element not found: \(element)")
        element.tap()
    }

    func type(_ text: String, into field: XCUIElement) {
        tap(field)
        field.typeText(text)
    }

    // The keyboard can cover the submit button on smaller screens
    func dismissKeyboardIfNeeded(before button: XCUIElement) {
        if button.waitForExistence(timeout: timeout), !button.isHittable, page.system.keyboardReturnKey.exists {
            page.system.keyboardReturnKey.tap()
        }
    }
}
