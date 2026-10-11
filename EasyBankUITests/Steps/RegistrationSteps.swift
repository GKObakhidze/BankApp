//
//  RegistrationSteps.swift
//  EasyBankUITests
//

import XCTest

final class RegistrationSteps: BaseSteps {
    @discardableResult
    func enterEmail(_ email: String) -> Self {
        type(email, into: page.registration.emailField)
        return self
    }

    @discardableResult
    func enterPassword(_ password: String) -> Self {
        revealAndType(password,
                      toggle: page.registration.passwordVisibilityToggle,
                      field: page.registration.plainPasswordField)
        return self
    }

    @discardableResult
    func repeatPassword(_ password: String) -> Self {
        revealAndType(password,
                      toggle: page.registration.repeatPasswordVisibilityToggle,
                      field: page.registration.plainRepeatPasswordField)
        return self
    }

    @discardableResult
    func submit() -> Self {
        dismissKeyboardIfNeeded(before: page.registration.submitButton)
        tap(page.registration.submitButton)
        return self
    }

    @discardableResult
    func register(email: String, password: String) -> Self {
        enterEmail(email).enterPassword(password).repeatPassword(password).submit()
    }

    @discardableResult
    func expectHome() -> HomeSteps {
        HomeSteps(app: app).assertDisplayed()
    }

    // A visible password field is a plain text field, so the system strong password prompt does not block typing
    private func revealAndType(_ text: String, toggle: XCUIElement, field: XCUIElement) {
        tap(toggle)
        type(text, into: field)
    }
}
