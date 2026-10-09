import XCTest

final class EasyBankSteps {
    private let page: EasyBankPage

    init(app: XCUIApplication) {
        page = EasyBankPage(app: app)
    }

    // Shared helpers

    private func waitUntilHittable(
        _ element: XCUIElement,
        timeout: TimeInterval = Constants.screenTimeout
    ) {
        XCTAssertTrue(
            element.waitForExistence(timeout: timeout),
            "Element was not found: \(element)"
        )

        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "isHittable == true"),
            object: element
        )

        XCTAssertEqual(
            XCTWaiter.wait(for: [expectation], timeout: timeout),
            .completed,
            "Element is not hittable: \(element)"
        )
    }

    private func tap(_ element: XCUIElement) {
        waitUntilHittable(element)
        element.tap()
    }

    private func enterText(
        _ text: String,
        into element: XCUIElement
    ) {
        tap(element)
        element.typeText(text)
    }

    private func enterVisiblePassword(
        _ password: String,
        visibilityButton: XCUIElement,
        visibleField: XCUIElement
    ) {
        tap(visibilityButton)

        // dismiss the iOS password suggestion if it appears
        if page.strongPasswordClose.waitForExistence(
            timeout: Constants.systemPromptTimeout
        ) {
            tap(page.strongPasswordClose)
        }

        tap(visibleField)
        visibleField.typeText(password)
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
        enterVisiblePassword(
            password,
            visibilityButton: page.loginPasswordVisibility,
            visibleField: page.visibleLoginPassword
        )
        return self
    }

    @discardableResult
    func submitLogin() -> Self {
        tap(page.loginSubmit)
        return self
    }

    @discardableResult
    func validateLoginErrorContains(_ expectedText: String) -> Self {
        XCTAssertTrue(
            page.loginError.waitForExistence(
                timeout: Constants.responseTimeout
            ),
            "Login error was not displayed"
        )

        XCTAssertTrue(
            page.loginError.label.contains(expectedText),
            "Expected error containing '\(expectedText)', " +
            "but got '\(page.loginError.label)'"
        )

        return self
    }

    @discardableResult
    func validateLoginScreen() -> Self {
        XCTAssertTrue(
            page.loginEmail.waitForExistence(
                timeout: Constants.screenTimeout
            ),
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
        enterVisiblePassword(
            password,
            visibilityButton: page.registrationPasswordVisibility,
            visibleField: page.visibleRegistrationPassword
        )
        return self
    }

    @discardableResult
    func enterRepeatPassword(_ password: String) -> Self {
        enterVisiblePassword(
            password,
            visibilityButton: page.repeatPasswordVisibility,
            visibleField: page.visibleRepeatPassword
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
    func validateHomeScreen() -> Self {
        XCTAssertTrue(
            page.sendMoney.waitForExistence(
                timeout: Constants.responseTimeout
            ),
            "Send Money button was not displayed"
        )

        XCTAssertTrue(
            page.homeTab.exists,
            "Home tab was not displayed"
        )

        return self
    }

    // Logout

    @discardableResult
    func logout() -> Self {
        tap(page.logoutButton)

        XCTAssertTrue(
            page.logoutAlert.waitForExistence(
                timeout: Constants.screenTimeout
            ),
            "Logout confirmation was not displayed"
        )

        tap(page.confirmLogout)
        return self
    }
}