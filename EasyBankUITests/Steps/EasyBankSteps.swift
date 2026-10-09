//
//  EasyBankSteps.swift
//  EasyBankUITests
//

import XCTest

final class EasyBankSteps {
    private let page: EasyBankPage
    private let timeout: TimeInterval = 10
    private let promptTimeout: TimeInterval = 2

    init(app: XCUIApplication) {
        self.page = EasyBankPage(app: app)
    }


    private func waitFor(_ element: XCUIElement, _ name: String,
                         file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(element.waitForExistence(timeout: timeout),
                      "\(name) did not appear within \(timeout)s", file: file, line: line)
    }

    private func tap(_ element: XCUIElement, _ name: String,
                     file: StaticString = #filePath, line: UInt = #line) {
        waitFor(element, name, file: file, line: line)
        element.tap()
    }

    private func type(_ text: String, into element: XCUIElement, _ name: String,
                      file: StaticString = #filePath, line: UInt = #line) {
        tap(element, name, file: file, line: line)
        element.typeText(text)
    }


    @discardableResult
    func assertOnboardingDisplayed() -> Self {
        waitFor(page.onboardingLoginButton, "Onboarding Log In button")
        waitFor(page.onboardingRegisterButton, "Onboarding Register button")
        return self
    }

    @discardableResult
    func openLogin() -> Self {
        tap(page.onboardingLoginButton, "Onboarding Log In button")
        return self
    }

    @discardableResult
    func openRegistration() -> Self {
        tap(page.onboardingRegisterButton, "Onboarding Register button")
        return self
    }


    @discardableResult
    func assertLoginFormDisplayed() -> Self {
        waitFor(page.loginEmailField, "Login email field")
        waitFor(page.loginPasswordField, "Login password field")
        waitFor(page.loginSubmitButton, "Login submit button")
        return self
    }

    @discardableResult
    func enterLoginEmail(_ email: String) -> Self {
        type(email, into: page.loginEmailField, "Login email field")
        return self
    }

    @discardableResult
    func enterLoginPassword(_ password: String) -> Self {
        type(password, into: page.loginPasswordField, "Login password field")
        return self
    }

    @discardableResult
    func dismissLoginKeyboard() -> Self {
        tap(page.loginTitle, "Login title")
        return self
    }

    @discardableResult
    func submitLogin() -> Self {
        tap(page.loginSubmitButton, "Login submit button")
        return self
    }

    @discardableResult
    func logIn(email: String, password: String) -> Self {
        assertLoginFormDisplayed()
        enterLoginEmail(email)
        enterLoginPassword(password)
        dismissLoginKeyboard()
        submitLogin()
        return self
    }

    @discardableResult
    func assertLoginErrorContains(_ fragment: String,
                                  file: StaticString = #filePath, line: UInt = #line) -> Self {
        waitFor(page.loginErrorText, "Login error message", file: file, line: line)
        let message = page.loginErrorText.label
        XCTAssertTrue(message.localizedCaseInsensitiveContains(fragment),
                      "Expected login error to contain '\(fragment)', got '\(message)'",
                      file: file, line: line)
        return self
    }


    @discardableResult
    func assertRegistrationFormDisplayed() -> Self {
        waitFor(page.registrationEmailField, "Registration email field")
        waitFor(page.registrationPasswordField, "Registration password field")
        waitFor(page.registrationRepeatPasswordField, "Registration repeat password field")
        return self
    }

    @discardableResult
    func enterRegistrationEmail(_ email: String) -> Self {
        type(email, into: page.registrationEmailField, "Registration email field")
        return self
    }

    @discardableResult
    func enterRegistrationPassword(_ password: String) -> Self {
        tap(page.registrationPasswordField, "Registration password field")
        dismissStrongPasswordPromptIfShown()
        page.registrationPasswordField.typeText(password)
        return self
    }

    @discardableResult
    func enterRegistrationRepeatPassword(_ password: String) -> Self {
        tap(page.registrationRepeatPasswordField, "Registration repeat password field")
        dismissStrongPasswordPromptIfShown()
        page.registrationRepeatPasswordField.typeText(password)
        return self
    }


    @discardableResult
    func dismissStrongPasswordPromptIfShown() -> Self {
        if page.strongPasswordCloseButton.waitForExistence(timeout: promptTimeout),
           page.strongPasswordCloseButton.isHittable {
            page.strongPasswordCloseButton.tap()
        }
        return self
    }

    @discardableResult
    func dismissRegistrationKeyboard() -> Self {
        tap(page.registrationTitle, "Registration title")
        return self
    }

    @discardableResult
    func submitRegistration() -> Self {
        tap(page.registrationSubmitButton, "Registration submit button")
        return self
    }

    @discardableResult
    func register(email: String, password: String) -> Self {
        assertRegistrationFormDisplayed()
        enterRegistrationEmail(email)
        enterRegistrationPassword(password)
        enterRegistrationRepeatPassword(password)
        dismissRegistrationKeyboard()
        submitRegistration()
        return self
    }


    @discardableResult
    func assertHomeDisplayed(file: StaticString = #filePath, line: UInt = #line) -> Self {
        waitFor(page.homeTabButton, "Home tab", file: file, line: line)
        waitFor(page.sendMoneyButton, "Send Money button", file: file, line: line)
        XCTAssertTrue(page.homeTabButton.isSelected, "Home tab is not selected", file: file, line: line)
        return self
    }

    @discardableResult
    func tapLogout() -> Self {
        tap(page.logoutButton, "Logout button")
        return self
    }

    @discardableResult
    func confirmLogout() -> Self {
        waitFor(page.logoutAlert, "Logging Out alert")
        tap(page.logoutConfirmButton, "Logout Yes button")
        return self
    }

    @discardableResult
    func logOut() -> Self {
        tapLogout()
        confirmLogout()
        assertLoginFormDisplayed()
        return self
    }
}
