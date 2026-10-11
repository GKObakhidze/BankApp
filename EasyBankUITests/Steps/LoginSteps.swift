//
//  LoginSteps.swift
//  EasyBankUITests
//

import XCTest

final class LoginSteps: BaseSteps {
    @discardableResult
    func enterEmail(_ email: String) -> Self {
        type(email, into: page.login.emailField)
        return self
    }

    @discardableResult
    func enterPassword(_ password: String) -> Self {
        type(password, into: page.login.passwordField)
        return self
    }

    @discardableResult
    func submit() -> Self {
        dismissKeyboardIfNeeded(before: page.login.submitButton)
        tap(page.login.submitButton)
        return self
    }

    @discardableResult
    func logIn(email: String, password: String) -> Self {
        enterEmail(email).enterPassword(password).submit()
    }

    @discardableResult
    func assertDisplayed() -> Self {
        XCTAssertTrue(page.login.emailField.waitForExistence(timeout: timeout), "Login form is not shown")
        return self
    }

    @discardableResult
    func assertErrorContains(_ fragment: String) -> Self {
        XCTAssertTrue(page.login.errorLabel.waitForExistence(timeout: timeout), "Login error is not shown")
        XCTAssertTrue(page.login.errorLabel.label.contains(fragment),
                      "Expected error to contain '\(fragment)', got '\(page.login.errorLabel.label)'")
        return self
    }

    @discardableResult
    func expectHome() -> HomeSteps {
        HomeSteps(app: app).assertDisplayed()
    }
}
