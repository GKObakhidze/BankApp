//
//  EasyBankSteps.swift
//  EasyBankUITests
//

import XCTest

class EasyBankSteps {

    private let page: EasyBankPage

    init(app: XCUIApplication) {
        page = EasyBankPage(app: app)
    }

    // onboarding

    @discardableResult
    func tapOnboardingLogIn() -> EasyBankSteps {
        tap(page.onboardingLoginButton, Constants.screenTimeout)
        return self
    }

    @discardableResult
    func tapOnboardingRegister() -> EasyBankSteps {
        tap(page.onboardingRegisterButton, Constants.screenTimeout)
        return self
    }

    // login form

    @discardableResult
    func verifyLoginFormIsDisplayed() -> EasyBankSteps {
        waitUntilExists(page.loginEmailField, Constants.screenTimeout)
        XCTAssertTrue(page.loginPasswordField.exists, "Login password field is not displayed")
        XCTAssertTrue(page.loginSubmitButton.exists, "Login button is not displayed")
        return self
    }

    @discardableResult
    func enterLoginEmail(_ email: String) -> EasyBankSteps {
        typeText(email, into: page.loginEmailField)
        return self
    }

    @discardableResult
    func enterLoginPassword(_ password: String) -> EasyBankSteps {
        typeSecureText(password, into: page.loginPasswordField)
        return self
    }

    @discardableResult
    func tapLogInSubmit() -> EasyBankSteps {
        tap(page.loginSubmitButton, Constants.screenTimeout)
        return self
    }

    @discardableResult
    func verifyLoginErrorContains(_ fragment: String) -> EasyBankSteps {
        waitUntilExists(page.loginError, Constants.responseTimeout)
        let errorText = page.loginError.label
        XCTAssertTrue(errorText.contains(fragment), "Login error '\(errorText)' does not contain '\(fragment)'")
        return self
    }

    @discardableResult
    func logIn(email: String, password: String) -> EasyBankSteps {
        verifyLoginFormIsDisplayed()
        enterLoginEmail(email)
        enterLoginPassword(password)
        tapLogInSubmit()
        return self
    }

    // registration form

    @discardableResult
    func verifyRegistrationFormIsDisplayed() -> EasyBankSteps {
        waitUntilExists(page.registrationEmailField, Constants.screenTimeout)
        XCTAssertTrue(page.registrationPasswordField.exists, "Password field is not displayed")
        XCTAssertTrue(page.registrationRepeatPasswordField.exists, "Repeat Password field is not displayed")
        XCTAssertTrue(page.registrationSubmitButton.exists, "Register button is not displayed")
        return self
    }

    @discardableResult
    func enterRegistrationEmail(_ email: String) -> EasyBankSteps {
        typeText(email, into: page.registrationEmailField)
        return self
    }

    @discardableResult
    func enterRegistrationPassword(_ password: String) -> EasyBankSteps {
        typeSecureText(password, into: page.registrationPasswordField)
        return self
    }

    @discardableResult
    func enterRepeatPassword(_ password: String) -> EasyBankSteps {
        typeSecureText(password, into: page.registrationRepeatPasswordField)
        return self
    }

    @discardableResult
    func tapRegisterSubmit() -> EasyBankSteps {
        tap(page.registrationSubmitButton, Constants.screenTimeout)
        return self
    }

    // home

    @discardableResult
    func verifyHomeScreenIsDisplayed() -> EasyBankSteps {
        waitUntilExists(page.sendMoneyButton, Constants.responseTimeout)
        XCTAssertTrue(page.homeTab.exists, "Home tab is not displayed")
        XCTAssertTrue(page.homeTab.isSelected, "Home tab is not selected")
        return self
    }

    @discardableResult
    func tapLogOut() -> EasyBankSteps {
        tap(page.logoutButton, Constants.screenTimeout)
        return self
    }

    @discardableResult
    func confirmLogOut() -> EasyBankSteps {
        waitUntilExists(page.logoutAlert, Constants.screenTimeout)
        tap(page.logoutConfirmButton, Constants.screenTimeout)
        return self
    }

    // shared helpers

    private func waitUntilExists(_ element: XCUIElement, _ timeout: TimeInterval) {
        XCTAssertTrue(element.waitForExistence(timeout: timeout), "\(element) did not appear in \(timeout) seconds")
    }

    private func waitUntilHittable(_ element: XCUIElement, _ timeout: TimeInterval) {
        let hittable = XCTNSPredicateExpectation(predicate: NSPredicate(format: "isHittable == true"), object: element)
        let result = XCTWaiter().wait(for: [hittable], timeout: timeout)
        XCTAssertEqual(result, .completed, "\(element) is not hittable after \(timeout) seconds")
    }

    private func tap(_ element: XCUIElement, _ timeout: TimeInterval) {
        waitUntilHittable(element, timeout)
        element.tap()
    }

    private func typeText(_ text: String, into field: XCUIElement) {
        tap(field, Constants.screenTimeout)
        waitUntilExists(page.keyboard, Constants.screenTimeout)
        field.typeText(text)
        XCTAssertEqual(field.value as? String, text, "\(field) does not contain the typed text")
    }

    private func typeSecureText(_ text: String, into field: XCUIElement) {
        tap(field, Constants.screenTimeout)
        dismissStrongPasswordPromptIfShown()
        waitUntilExists(page.keyboard, Constants.screenTimeout)
        // tap keyboard keys like a user: typeText keeps only one character in the registration form on iOS 18
        for character in text {
            tapKeyboardKey(character)
        }
        let typedCount = (field.value as? String)?.count ?? 0
        XCTAssertEqual(typedCount, text.count, "\(field) contains \(typedCount) of \(text.count) characters")
    }

    private func tapKeyboardKey(_ character: Character) {
        let key = page.keyboardKey(character)
        // switch letters / capitals / numbers / symbols until the key is shown
        var switches = 0
        while !key.exists && switches < Constants.maxKeyboardSwitches {
            let switchKey = switches % 2 == 0 ? page.keyboardShiftKey : page.keyboardLayoutKey
            if switchKey.exists {
                switchKey.tap()
            }
            switches += 1
        }
        XCTAssertTrue(key.exists, "Keyboard key '\(character)' was not found")
        key.tap()
    }

    private func dismissStrongPasswordPromptIfShown() {
        if page.strongPasswordCloseButton.waitForExistence(timeout: Constants.systemPromptTimeout) {
            page.strongPasswordCloseButton.tap()
        }
    }
}
