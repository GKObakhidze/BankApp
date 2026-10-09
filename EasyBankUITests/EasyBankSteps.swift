//
//  EasyBankSteps.swift
//  EasyBankUITests
//

import XCTest

final class EasyBankSteps {
    private let page = EasyBankPage()

    // MARK: - Onboarding

    @discardableResult
    func openLoginForm() -> EasyBankSteps {
        step("Opening the login form from onboarding") {
            tap(page.onboardingLoginButton)
        }
    }

    @discardableResult
    func openRegistrationForm() -> EasyBankSteps {
        step("Opening the registration form from onboarding") {
            tap(page.onboardingRegisterButton)
        }
    }

    // MARK: - Login

    @discardableResult
    func enterLoginEmail(_ email: String) -> EasyBankSteps {
        step("Entering the login email") {
            enterText(email, into: page.loginEmailField)
        }
    }

    @discardableResult
    func enterLoginPassword(_ password: String) -> EasyBankSteps {
        step("Entering the login password") {
            enterText(password, into: page.loginPasswordField)
        }
    }

    @discardableResult
    func submitLogin() -> EasyBankSteps {
        step("Submitting the login form") {
            tap(page.loginSubmitButton)
        }
    }

    @discardableResult
    func logIn(email: String, password: String) -> EasyBankSteps {
        step("Logging in with email and password") {
            enterLoginEmail(email)
            enterLoginPassword(password)
            submitLogin()
        }
    }

    @discardableResult
    func verifyLoginFormDisplayed() -> EasyBankSteps {
        step("Verifying the login form is displayed") {
            XCTAssertTrue(page.loginEmailField.waitForExistence(timeout: EasyBankConstants.Timeout.element),
                          "The login form is not displayed")
        }
    }

    @discardableResult
    func verifyLoginError(contains fragment: String) -> EasyBankSteps {
        step("Verifying the login error message") {
            let error = page.loginErrorMessage
            XCTAssertTrue(error.waitForExistence(timeout: EasyBankConstants.Timeout.element),
                          "The login error message is not displayed")
            XCTAssertTrue(error.label.contains(fragment),
                          "Expected the login error to contain \"\(fragment)\", got \"\(error.label)\"")
        }
    }

    // MARK: - Registration

    @discardableResult
    func enterRegistrationEmail(_ email: String) -> EasyBankSteps {
        step("Entering the registration email") {
            enterText(email, into: page.registrationEmailField)
        }
    }

    @discardableResult
    func enterRegistrationPassword(_ password: String) -> EasyBankSteps {
        step("Entering the registration password") {
            typePassword(password, into: page.registrationPasswordField)
        }
    }

    @discardableResult
    func repeatRegistrationPassword(_ password: String) -> EasyBankSteps {
        step("Repeating the registration password") {
            typePassword(password, into: page.registrationRepeatPasswordField)
        }
    }

    @discardableResult
    func submitRegistration() -> EasyBankSteps {
        step("Submitting the registration form") {
            tap(page.registrationSubmitButton)
        }
    }

    @discardableResult
    func register(email: String, password: String) -> EasyBankSteps {
        step("Registering a new account") {
            enterRegistrationEmail(email)
            enterRegistrationPassword(password)
            repeatRegistrationPassword(password)
            submitRegistration()
        }
    }

    // MARK: - Home

    @discardableResult
    func verifyMainScreenDisplayed() -> EasyBankSteps {
        step("Verifying the main screen is displayed") {
            XCTAssertTrue(page.homeTab.waitForExistence(timeout: EasyBankConstants.Timeout.element),
                          "The Home tab is not displayed")
            XCTAssertTrue(page.sendMoneyButton.waitForExistence(timeout: EasyBankConstants.Timeout.element),
                          "The Send Money button is not displayed")
        }
    }

    @discardableResult
    func requestLogout() -> EasyBankSteps {
        step("Requesting logout") {
            tap(page.logoutButton)
        }
    }

    @discardableResult
    func confirmLogout() -> EasyBankSteps {
        step("Confirming logout") {
            XCTAssertTrue(page.logoutAlert.waitForExistence(timeout: EasyBankConstants.Timeout.element),
                          "The logout confirmation is not displayed")
            tap(page.logoutConfirmButton)
        }
    }

    @discardableResult
    func logOut() -> EasyBankSteps {
        step("Logging out") {
            requestLogout()
            confirmLogout()
        }
    }

    // MARK: - Helpers

    private func step(_ name: String, _ body: () -> Void) -> EasyBankSteps {
        XCTContext.runActivity(named: name) { _ in body() }
        return self
    }

    private func tap(_ element: XCUIElement) {
        XCTAssertTrue(element.waitUntilHittable(timeout: EasyBankConstants.Timeout.element),
                      "\(element) is not available for tapping")
        element.tap()
    }

    private func enterText(_ text: String, into field: XCUIElement) {
        tap(field)
        field.typeText(text)
    }

    private func typePassword(_ password: String, into field: XCUIElement) {
        tap(field)
        if dismissStrongPasswordPromptIfPresent() {
            tap(field)
        }
        field.typeText(password)
    }

    private func dismissStrongPasswordPromptIfPresent() -> Bool {
        if page.strongPasswordCloseButton.waitForExistence(timeout: EasyBankConstants.Timeout.optionalPrompt) {
            page.strongPasswordCloseButton.tap()
            return true
        }
        if page.systemStrongPasswordCloseButton.exists {
            page.systemStrongPasswordCloseButton.tap()
            return true
        }
        return false
    }
}
