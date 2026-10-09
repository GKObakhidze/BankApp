import XCTest

class EasyBankSteps {
    let page: EasyBankPage

    init(_ app: XCUIApplication) {
        page = EasyBankPage(app)
    }

    private func type(_ text: String, into field: XCUIElement) {
        XCTAssertTrue(field.waitForExistence(timeout: Timeout.standard), FailureMessage.fieldNotFound)
        field.tap()
        if page.strongPasswordClose.waitForExistence(timeout: Timeout.prompt) {
            page.strongPasswordClose.tap()
        }
        field.typeText(text)
    }

    private func typeRevealed(_ text: String, into field: XCUIElement) {
        XCTAssertTrue(field.waitForExistence(timeout: Timeout.standard), FailureMessage.fieldNotFound)
        field.buttons["hide"].tap()
        field.tap()
        field.typeText(text)
    }

    private func dismissKeyboard() {
        if page.keyboardReturn.exists { page.keyboardReturn.tap() }
    }

    func openLogin() {
        XCTAssertTrue(page.onboardingLogin.waitForExistence(timeout: Timeout.standard))
        page.onboardingLogin.tap()
    }

    func logIn(email: String, password: String) {
        type(email, into: page.loginEmail)
        type(password, into: page.loginPassword)
        dismissKeyboard()
        page.loginSubmit.tap()
    }

    func assertLoginError(contains fragment: String) {
        XCTAssertTrue(page.loginError.waitForExistence(timeout: Timeout.standard), FailureMessage.errorNotShown)
        XCTAssertTrue(page.loginError.label.contains(fragment),
                      FailureMessage.wrongError(expected: fragment, actual: page.loginError.label))
    }

    func register(email: String, password: String) {
        XCTAssertTrue(page.onboardingRegister.waitForExistence(timeout: Timeout.standard))
        page.onboardingRegister.tap()
        type(email, into: page.registerEmail)
        typeRevealed(password, into: page.registerPassword)
        typeRevealed(password, into: page.registerRepeatPassword)
        dismissKeyboard()
        page.registerSubmit.tap()
    }

    func assertMainScreen() {
        XCTAssertTrue(page.sendMoney.waitForExistence(timeout: Timeout.long), FailureMessage.mainScreenNotDisplayed)
    }

    func logOut() {
        XCTAssertTrue(page.logout.waitForExistence(timeout: Timeout.standard))
        page.logout.tap()
        XCTAssertTrue(page.logoutYes.waitForExistence(timeout: Timeout.medium))
        page.logoutYes.tap()
        XCTAssertTrue(page.loginEmail.waitForExistence(timeout: Timeout.standard), FailureMessage.loginFormNotDisplayed)
    }
}