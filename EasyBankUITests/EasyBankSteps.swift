import XCTest

final class EasyBankSteps {
    private let app: XCUIApplication
    private let page: EasyBankPage

    init(app: XCUIApplication) {
        self.app = app
        self.page = EasyBankPage(app: app)
    }

    @discardableResult
    func openLogin() -> EasyBankSteps {
        tap(page.onboardingLoginButton)
        return self
    }

    @discardableResult
    func openRegistration() -> EasyBankSteps {
        tap(page.onboardingRegisterButton)
        return self
    }

    @discardableResult
    func enterLoginEmail(_ email: String) -> EasyBankSteps {
        type(email, into: page.loginEmailField)
        return self
    }

    @discardableResult
    func enterLoginPassword(_ password: String) -> EasyBankSteps {
        type(password, into: page.loginPasswordField)
        return self
    }

    @discardableResult
    func submitLogin() -> EasyBankSteps {
        tap(page.loginSubmitButton)
        return self
    }

    @discardableResult
    func verifyLoginErrorContains(_ text: String) -> EasyBankSteps {
        XCTAssertTrue(
            page.loginError.waitForExistence(timeout: 10),
            "Login error was not displayed"
        )

        XCTAssertTrue(
            page.loginError.label.localizedCaseInsensitiveContains(text),
            "Expected login error to contain '\(text)', but got '\(page.loginError.label)'"
        )

        return self
    }

    @discardableResult
    func enterRegistrationEmail(_ email: String) -> EasyBankSteps {
        type(email, into: page.registrationEmailField)
        return self
    }

    @discardableResult
    func enterRegistrationPassword(_ password: String) -> EasyBankSteps {
        XCTAssertTrue(
            page.registrationPasswordField.waitForExistence(timeout: 10),
            "Registration password field was not displayed"
        )

        page.registrationPasswordField.tap()
        dismissStrongPasswordPromptIfPresent()

        XCTAssertTrue(
            page.registrationPasswordVisibilityButton.waitForExistence(timeout: 5),
            "Password visibility button was not displayed"
        )

        page.registrationPasswordVisibilityButton.tap()
        type(password, into: page.registrationPasswordField)

        return self
    }

    @discardableResult
    func enterRegistrationRepeatPassword(_ password: String) -> EasyBankSteps {
        XCTAssertTrue(
            page.registrationRepeatPasswordField.waitForExistence(timeout: 10),
            "Repeat password field was not displayed"
        )

        page.registrationRepeatPasswordField.tap()
        dismissStrongPasswordPromptIfPresent()

        XCTAssertTrue(
            page.registrationRepeatPasswordVisibilityButton.waitForExistence(timeout: 5),
            "Repeat password visibility button was not displayed"
        )

        page.registrationRepeatPasswordVisibilityButton.tap()
        type(password, into: page.registrationRepeatPasswordField)

        return self
    }

    @discardableResult
    func submitRegistration() -> EasyBankSteps {
        tap(page.registrationSubmitButton)
        return self
    }

    @discardableResult
    func verifyHomeDisplayed() -> EasyBankSteps {
        XCTAssertTrue(
            page.sendMoneyButton.waitForExistence(timeout: 10),
            "Home screen was not displayed"
        )

        return self
    }

    @discardableResult
    func logout() -> EasyBankSteps {
        tap(page.logoutButton)

        XCTAssertTrue(
            page.logoutAlert.waitForExistence(timeout: 10),
            "Logout confirmation alert was not displayed"
        )

        tap(page.logoutYesButton)

        XCTAssertTrue(
            page.loginEmailField.waitForExistence(timeout: 10),
            "Login screen was not displayed after logout"
        )

        return self
    }

    private func type(_ text: String, into element: XCUIElement) {
        XCTAssertTrue(
            element.waitForExistence(timeout: 10),
            "Expected input element was not displayed"
        )

        element.tap()
        element.typeText(text)
    }

    private func tap(_ element: XCUIElement) {
        XCTAssertTrue(
            element.waitForExistence(timeout: 10),
            "Expected element was not displayed"
        )

        for _ in 0..<3 {
            if element.isHittable {
                break
            }
            app.swipeUp()
        }

        XCTAssertTrue(
            element.isHittable,
            "Expected element was not hittable"
        )

        element.tap()
    }

    private func dismissStrongPasswordPromptIfPresent() {
        if page.strongPasswordCloseButtonInApp.waitForExistence(timeout: 1) {
            page.strongPasswordCloseButtonInApp.tap()
            return
        }

        if page.strongPasswordCloseButtonInSpringboard.waitForExistence(timeout: 1) {
            page.strongPasswordCloseButtonInSpringboard.tap()
        }
    }
}