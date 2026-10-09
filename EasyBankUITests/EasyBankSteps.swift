import XCTest

class EasyBankSteps {
    let page: EasyBankPage

    init(_ app: XCUIApplication) {
        page = EasyBankPage(app)
    }

    private func type(_ text: String, into field: XCUIElement, dismissingStrongPassword: Bool = false) {
    XCTAssertTrue(field.waitForExistence(timeout: Timeout.standard), FailureMessage.fieldNotFound)
    field.tap()
    if dismissingStrongPassword, page.strongPasswordClose.waitForExistence(timeout: Timeout.medium) {
        page.strongPasswordClose.tap()
    }
    field.typeText(text)
}

    func logIn(email: String, password: String) {
        XCTAssertTrue(page.onboardingLogin.waitForExistence(timeout: Timeout.standard))
        page.onboardingLogin.tap()
        type(email, into: page.loginEmail)
        type(password, into: page.loginPassword)
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
    type(password, into: page.registerPassword, dismissingStrongPassword: true)
    type(password, into: page.registerRepeatPassword, dismissingStrongPassword: true)
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
    }
}