import XCTest

final class EasyBankSteps {

    private let page: EasyBankPage

    init(app: XCUIApplication) {
        self.page = EasyBankPage(app: app)
    }

    func openLoginForm() {
        waitAndTap(page.onboardingLoginButton, elementName: nameOnboardingLogin)
    }

    func openRegistrationForm() {
        waitAndTap(page.onboardingRegisterButton, elementName: nameOnboardingRegister)
    }

    func enterLoginEmail(_ email: String) {
        enterText(email, into: page.loginEmailField, elementName: nameLoginEmail)
    }

    func enterLoginPassword(_ password: String) {
        enterText(password, into: page.loginPasswordField, elementName: nameLoginPassword)
    }

    func submitLoginForm() {
        waitUntilExists(page.loginSubmitButton, elementName: nameLoginSubmit)
        if !page.loginSubmitButton.isHittable {
            hideKeyboardIfShown()
        }
        waitAndTap(page.loginSubmitButton, elementName: nameLoginSubmit)
    }

    func logIn(email: String, password: String) {
        enterLoginEmail(email)
        enterLoginPassword(password)
        submitLoginForm()
    }

    func waitForLoginForm() {
        waitUntilExists(page.loginEmailField, elementName: nameLoginForm)
    }

    func assertLoginError(contains fragment: String) {
        waitUntilExists(page.loginErrorLabel, elementName: nameLoginError)
        let text = page.loginErrorLabel.label
        XCTAssertTrue(text.contains(fragment),
                      "Expected login error to contain '\(fragment)', but was '\(text)'")
    }

    func registerAccount(email: String, password: String) {
        enterText(email, into: page.registrationEmailField, elementName: nameRegistrationEmail)
        enterNewPassword(password, into: page.registrationPasswordField, elementName: nameRegistrationPassword)
        enterNewPassword(password, into: page.registrationRepeatPasswordField, elementName: nameRegistrationRepeatPassword)
        if !page.registrationSubmitButton.isHittable {
            hideKeyboardIfShown()
        }
        waitAndTap(page.registrationSubmitButton, elementName: nameRegistrationSubmit)
    }

    func assertHomeDisplayed() {
        waitUntilExists(page.homeSendMoneyButton, elementName: nameHomeSendMoney)
        XCTAssertTrue(page.homeLogoutButton.exists, logoutButtonMissingMessage)
    }

    func logOut() {
        waitAndTap(page.homeLogoutButton, elementName: nameHomeLogout)
        waitUntilExists(page.logoutAlert, elementName: nameLogoutDialog)
        waitAndTap(page.logoutConfirmYesButton, elementName: nameLogoutYes)
    }

    private func waitUntilExists(_ element: XCUIElement, elementName: String) {
        XCTAssertTrue(element.waitForExistence(timeout: standardTimeout),
                      "'\(elementName)' did not appear within \(standardTimeout)s")
    }

    private func waitAndTap(_ element: XCUIElement, elementName: String) {
        waitUntilExists(element, elementName: elementName)
        element.tap()
    }

    private func enterText(_ text: String, into field: XCUIElement, elementName: String) {
        waitAndTap(field, elementName: elementName)
        field.typeText(text)
    }

    private func enterNewPassword(_ password: String, into field: XCUIElement, elementName: String) {
        waitAndTap(field, elementName: elementName)
        closeStrongPasswordPromptIfShown()
        field.typeText(password)
    }

    private func closeStrongPasswordPromptIfShown() {
        if page.strongPasswordCloseButton.waitForExistence(timeout: optionalTimeout) {
            page.strongPasswordCloseButton.tap()
        }
    }

    private func hideKeyboardIfShown() {
        if page.keyboardReturnKey.exists {
            page.keyboardReturnKey.tap()
        }
    }
}