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
        type(password, into: page.registration.passwordField)
        dismissStrongPasswordPromptIfPresent()
        return self
    }

    @discardableResult
    func repeatPassword(_ password: String) -> Self {
        type(password, into: page.registration.repeatPasswordField)
        dismissStrongPasswordPromptIfPresent()
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
}
