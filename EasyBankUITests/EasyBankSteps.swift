import XCTest

class EasyBankSteps {
    private let page = EasyBankPage()
    private let timeout: TimeInterval = 10

    @discardableResult
    func tapOnboardingLogin() -> Self {
        tap(page.onboardingLoginButton)
    }

    @discardableResult
    func tapOnboardingRegister() -> Self {
        tap(page.onboardingRegisterButton)
    }

    @discardableResult
    func enterLoginEmail(_ email: String) -> Self {
        type(email, into: page.loginEmailField)
    }

    @discardableResult
    func enterLoginPassword(_ password: String) -> Self {
        type(password, into: page.loginPasswordField)
    }

    @discardableResult
    func tapLoginSubmit() -> Self {
        tap(page.loginSubmitButton)
    }

    @discardableResult
    func validateLoginErrorContains(_ text: String) -> Self {
        XCTAssertTrue(page.loginError.waitForExistence(timeout: timeout))
        XCTAssertTrue(page.loginError.label.contains(text))
        return self
    }

    @discardableResult
    func enterRegistrationEmail(_ email: String) -> Self {
        type(email, into: page.registrationEmailField)
    }

    @discardableResult
    func enterRegistrationPassword(_ password: String) -> Self {
        typeSecure(password, into: page.registrationPasswordField)
    }

    @discardableResult
    func enterRegistrationRepeatPassword(_ password: String) -> Self {
        typeSecure(password, into: page.registrationRepeatPasswordField)
    }

    @discardableResult
    func tapRegistrationSubmit() -> Self {
        tap(page.registrationSubmitButton)
    }

    @discardableResult
    func validateHomeDisplayed() -> Self {
        XCTAssertTrue(page.homeTab.waitForExistence(timeout: timeout))
        XCTAssertTrue(page.sendMoneyButton.exists)
        return self
    }

    @discardableResult
    func tapLogout() -> Self {
        tap(page.logoutButton)
    }

    @discardableResult
    func confirmLogout() -> Self {
        tap(page.logoutYesButton)
    }

    @discardableResult
    private func tap(_ element: XCUIElement) -> Self {
        XCTAssertTrue(element.waitForExistence(timeout: timeout))
        element.tap()
        return self
    }

    private func type(_ text: String, into element: XCUIElement) -> Self {
        tap(element)
        element.typeText(text)
        return self
    }

    private func typeSecure(_ text: String, into element: XCUIElement) -> Self {
        tap(element)
        if page.strongPasswordCloseButton.waitForExistence(timeout: 2) {
            page.strongPasswordCloseButton.tap()
            element.tap()
        }
        element.typeText(XCUIKeyboardKey.delete.rawValue)
        element.typeText(text)
        return self
    }
}