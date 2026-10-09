
import XCTest

final class EasyBankSteps {

    private let page: EasyBankPage

    init(app: XCUIApplication) {
        self.page = EasyBankPage(app: app)
    }

    // Reusable Helpers

    private func tap(_ element: XCUIElement) {
        XCTAssertTrue(
            element.waitForExistence(timeout: 10),
            "Element was not found"
        )

        element.tap()
    }

    private func enterText(
        _ text: String,
        into element: XCUIElement
    ) {
        XCTAssertTrue(
            element.waitForExistence(timeout: 10),
            "Input field was not found"
        )

        element.tap()
        element.typeText(text)
    }

    private func enterRegistrationPasswordText(
        _ password: String,
        into element: XCUIElement
    ) {
        XCTAssertTrue(
            element.waitForExistence(timeout: 10),
            "Password field was not found"
        )

        element.tap()

        if page.strongPasswordClose.waitForExistence(timeout: 1) {
            page.strongPasswordClose.tap()
            element.tap()
        }

        element.typeText(password)
    }

    // Onboarding

    @discardableResult
    func openLogin() -> Self {
        tap(page.onboardingLogin)
        return self
    }

    @discardableResult
    func openRegistration() -> Self {
        tap(page.onboardingRegister)
        return self
    }

    // Login

    @discardableResult
    func enterEmail(_ email: String) -> Self {
        enterText(email, into: page.loginEmail)
        return self
    }

    @discardableResult
    func enterPassword(_ password: String) -> Self {
        enterText(password, into: page.loginPassword)
        return self
    }

    @discardableResult
    func submitLogin() -> Self {
        tap(page.loginSubmit)
        return self
    }

    @discardableResult
    func verifyLoginError(_ expectedText: String) -> Self {
        let error = page.loginError

        XCTAssertTrue(
            error.waitForExistence(timeout: 10),
            "Login error was not displayed"
        )

        XCTAssertTrue(
            error.label.contains(expectedText),
            "Unexpected login error: \(error.label)"
        )

        return self
    }

    @discardableResult
    func verifyLoginScreen() -> Self {
        XCTAssertTrue(
            page.loginEmail.waitForExistence(timeout: 10),
            "Login screen was not displayed"
        )

        return self
    }

    // Registration

    @discardableResult
    func enterRegistrationEmail(_ email: String) -> Self {
        enterText(email, into: page.registrationEmail)
        return self
    }

    @discardableResult
    func enterRegistrationPassword(_ password: String) -> Self {
        enterRegistrationPasswordText(
            password,
            into: page.registrationPassword
        )

        return self
    }

    @discardableResult
    func enterRepeatPassword(_ password: String) -> Self {
        enterRegistrationPasswordText(
            password,
            into: page.repeatPassword
        )

        return self
    }

    @discardableResult
    func submitRegistration() -> Self {
        tap(page.registrationSubmit)
        return self
    }

    // Home

    @discardableResult
    func verifyHomeScreen() -> Self {
        XCTAssertTrue(
            page.sendMoney.waitForExistence(timeout: 15),
            "Home screen was not displayed"
        )

        return self
    }

    // Logout

    @discardableResult
    func openLogoutConfirmation() -> Self {
        tap(page.logoutButton)
        return self
    }

    @discardableResult
    func confirmLogout() -> Self {
        XCTAssertTrue(
            page.logoutAlert.waitForExistence(timeout: 10),
            "Logout confirmation was not displayed"
        )

        tap(page.confirmLogout)

        return self
    }
}
