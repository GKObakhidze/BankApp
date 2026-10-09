import XCTest

class EasyBankSteps: EasyBankPage {

    // MARK: - Shared helpers

    func tapElement(_ element: XCUIElement) {
        XCTAssertTrue(element.waitForExistence(timeout: 10), "Element not found: \(element)")
        element.tap()
    }

    func enterText(_ text: String, into element: XCUIElement) {
        tapElement(element)
        element.typeText(text)
    }

    // MARK: - Onboarding

    func openLoginFromOnboarding() {
        tapElement(onboardingLoginButton)
    }

    func openRegistrationFromOnboarding() {
        tapElement(onboardingRegisterButton)
    }

    // MARK: - Login

    func enterLoginEmail(_ email: String) {
        enterText(email, into: loginEmailField)
    }

    func enterLoginPassword(_ password: String) {
        enterText(password, into: loginPasswordField)
    }

    func tapLoginSubmit() {
        tapElement(loginSubmitButton)
    }

    func login(email: String, password: String) {
        enterLoginEmail(email)
        enterLoginPassword(password)
        tapLoginSubmit()
    }

    func assertLoginFormDisplayed() {
        XCTAssertTrue(loginEmailField.waitForExistence(timeout: 10), "Login form is not displayed")
    }

    func assertLoginErrorContains(_ fragments: [String]) {
        XCTAssertTrue(loginErrorText.waitForExistence(timeout: 10), "Login error is not displayed")
        let message = loginErrorText.label
        let found = fragments.contains { message.contains($0) }
        XCTAssertTrue(found, "Error \"\(message)\" does not contain any of \(fragments)")
    }

    // MARK: - Registration

    func dismissStrongPasswordPromptIfPresent(for field: XCUIElement) {
        if strongPasswordCloseButton.waitForExistence(timeout: 3) {
            strongPasswordCloseButton.tap()
            tapElement(field)
        }
    }

    func enterRegistrationEmail(_ email: String) {
        enterText(email, into: registrationEmailField)
    }

    func enterRegistrationPassword(_ password: String) {
        tapElement(registrationPasswordField)
        dismissStrongPasswordPromptIfPresent(for: registrationPasswordField)
        registrationPasswordField.typeText(password)
    }

    func enterRegistrationRepeatPassword(_ password: String) {
        tapElement(registrationRepeatPasswordField)
        dismissStrongPasswordPromptIfPresent(for: registrationRepeatPasswordField)
        registrationRepeatPasswordField.typeText(password)
    }

    func tapRegistrationSubmit() {
        tapElement(registrationSubmitButton)
    }

    func register(email: String, password: String) {
        enterRegistrationEmail(email)
        enterRegistrationPassword(password)
        enterRegistrationRepeatPassword(password)
        tapRegistrationSubmit()
    }

    // MARK: - Home

    func assertMainScreenDisplayed() {
        XCTAssertTrue(sendMoneyButton.waitForExistence(timeout: 15), "Send Money button is not displayed")
        XCTAssertTrue(homeTabButton.exists, "Home tab is not displayed")
    }

    func logout() {
        tapElement(logoutButton)
        tapElement(logoutConfirmButton)
    }
}