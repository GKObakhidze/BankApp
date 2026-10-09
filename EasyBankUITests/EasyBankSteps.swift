import XCTest

class EasyBankSteps: EasyBankPage {

    func tapElement(_ element: XCUIElement) {
        XCTAssertTrue(element.waitForExistence(timeout: 10), "Element not found: \(element)")
        element.tap()
    }

    func enterText(_ text: String, into element: XCUIElement) {
        tapElement(element)
        element.typeText(text)
    }

    func openLoginFromOnboarding() {
        tapElement(onboardingLoginButton)
    }

    func openRegistrationFromOnboarding() {
        tapElement(onboardingRegisterButton)
    }


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

    func showRegistrationPasswords() {
        tapElement(registrationPasswordToggle)
        tapElement(registrationRepeatPasswordToggle)
    }

    func enterRegistrationEmail(_ email: String) {
        enterText(email, into: registrationEmailField)
    }

    func enterRegistrationPassword(_ password: String) {
        enterText(password, into: registrationPasswordField)
    }

    func enterRegistrationRepeatPassword(_ password: String) {
        enterText(password, into: registrationRepeatPasswordField)
    }

    func tapRegistrationSubmit() {
        tapElement(registrationSubmitButton)
    }

    func register(email: String, password: String) {
        showRegistrationPasswords()
        enterRegistrationEmail(email)
        enterRegistrationPassword(password)
        enterRegistrationRepeatPassword(password)
        tapRegistrationSubmit()
    }


    func assertMainScreenDisplayed() {
        XCTAssertTrue(sendMoneyButton.waitForExistence(timeout: 15), "Send Money button is not displayed")
        XCTAssertTrue(homeTabButton.exists, "Home tab is not displayed")
    }

    func logout() {
        tapElement(logoutButton)
        tapElement(logoutConfirmButton)
    }
}