import XCTest

class EasyBankSteps {
    private let app: XCUIApplication
    private let page: EasyBankPage
    private let defaultTimeout: TimeInterval = 7.0

    init(app: XCUIApplication) {
        self.app = app
        self.page = EasyBankPage(app: app)
    }

    @discardableResult
    func tapOnboardingLogin() -> Self {
        XCTAssertTrue(page.onboardingLoginButton.waitForExistence(timeout: defaultTimeout))
        page.onboardingLoginButton.tap()
        return self
    }

    @discardableResult
    func tapOnboardingRegister() -> Self {
        XCTAssertTrue(page.onboardingRegisterButton.waitForExistence(timeout: defaultTimeout))
        page.onboardingRegisterButton.tap()
        return self
    }

    @discardableResult
    func enterLoginEmail(_ email: String) -> Self {
        XCTAssertTrue(page.loginEmailField.waitForExistence(timeout: defaultTimeout))
        page.loginEmailField.tap()
        page.loginEmailField.typeText(email)
        return self
    }

    @discardableResult
    func enterLoginPassword(_ password: String) -> Self {
        XCTAssertTrue(page.loginPasswordField.waitForExistence(timeout: defaultTimeout))
        page.loginPasswordField.tap()
        dismissStrongPasswordPromptIfNeeded()
        page.loginPasswordField.typeText(password)
        return self
    }

    @discardableResult
    func tapLoginSubmit() -> Self {
        XCTAssertTrue(page.loginSubmitButton.waitForExistence(timeout: defaultTimeout))
        page.loginSubmitButton.tap()
        return self
    }

    @discardableResult
    func enterRegisterEmail(_ email: String) -> Self {
        XCTAssertTrue(page.registerEmailField.waitForExistence(timeout: defaultTimeout))
        page.registerEmailField.tap()
        page.registerEmailField.typeText(email)
        return self
    }

    @discardableResult
    func enterRegisterPassword(_ password: String) -> Self {
        XCTAssertTrue(page.registerPasswordField.waitForExistence(timeout: defaultTimeout))
        page.registerPasswordField.tap()
        dismissStrongPasswordPromptIfNeeded()
        page.registerPasswordField.typeText(password)
        return self
    }

    @discardableResult
    func enterRegisterRepeatPassword(_ password: String) -> Self {
        XCTAssertTrue(page.registerRepeatPasswordField.waitForExistence(timeout: defaultTimeout))
        page.registerRepeatPasswordField.tap()
        dismissStrongPasswordPromptIfNeeded()
        page.registerRepeatPasswordField.typeText(password)
        return self
    }

    @discardableResult
    func tapRegisterSubmit() -> Self {
        XCTAssertTrue(page.registerSubmitButton.waitForExistence(timeout: defaultTimeout))
        page.registerSubmitButton.tap()
        return self
    }

    @discardableResult
    func dismissStrongPasswordPromptIfNeeded() -> Self {
        if page.strongPasswordCloseButton.waitForExistence(timeout: 2.0) {
            page.strongPasswordCloseButton.tap()
        }
        return self
    }

    @discardableResult
    func tapLogout() -> Self {
        XCTAssertTrue(page.logoutButton.waitForExistence(timeout: defaultTimeout))
        page.logoutButton.tap()
        return self
    }

    @discardableResult
    func confirmLogout() -> Self {
        XCTAssertTrue(page.logoutConfirmAlertButton.waitForExistence(timeout: defaultTimeout))
        page.logoutConfirmAlertButton.tap()
        return self
    }

    @discardableResult
    func assertErrorMessageContains(_ fragment: String) -> Self {
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", fragment)
        let element = page.errorLabels.containing(predicate).firstMatch
        XCTAssertTrue(element.waitForExistence(timeout: defaultTimeout))
        return self
    }

    @discardableResult
    func assertMainScreenDisplayed() -> Self {
        let homeExists = page.homeTab.waitForExistence(timeout: defaultTimeout)
        let sendMoneyExists = page.sendMoneyButton.waitForExistence(timeout: defaultTimeout)
        XCTAssertTrue(homeExists || sendMoneyExists)
        return self
    }
}
