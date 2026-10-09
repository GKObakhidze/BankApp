
import XCTest

final class EasyBankSteps {

    private let page: EasyBankPage

    init(app: XCUIApplication) {
        self.page = EasyBankPage(app: app)
    }

    // Reusable Helpers

    private func waitUntilHittable(_ element: XCUIElement) {
        XCTAssertTrue(element.waitForExistence(timeout: 10),
                      "Element was not found: \(element)")
        let ready = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "hittable == true AND enabled == true"),
            object: element
        )
        XCTAssertEqual(XCTWaiter.wait(for: [ready], timeout: 10), .completed,
                       "Element was not ready for interaction: \(element)")
    }

    private func tap(_ element: XCUIElement) {
        waitUntilHittable(element)
        element.tap()
    }

    private func enterText(
        _ text: String,
        into element: XCUIElement
    ) {
        waitUntilHittable(element)
        element.tap()
        element.typeText(text)
    }

    private func enterVisiblePasswordText(
        _ password: String,
        using visibilityButton: XCUIElement,
        into visibleField: XCUIElement
    ) {
        // The instructor permits visible test passwords. Toggle before
        // focusing to avoid the system's secure-field password suggestion.
        tap(visibilityButton)
        waitUntilHittable(visibleField)
        visibleField.tap()

        if page.strongPasswordClose.waitForExistence(timeout: 1) {
            tap(page.strongPasswordClose)
            tap(visibleField)
        }

        visibleField.typeText(password)
        let entered = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "value == %@", password),
            object: visibleField
        )
        XCTAssertEqual(XCTWaiter.wait(for: [entered], timeout: 5), .completed,
                       "Password was not entered correctly")
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
        enterVisiblePasswordText(
            password,
            using: page.loginPasswordVisibility,
            into: page.visibleLoginPassword
        )
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
        enterVisiblePasswordText(
            password,
            using: page.registrationPasswordVisibility,
            into: page.visibleRegistrationPassword
        )

        return self
    }

    @discardableResult
    func enterRepeatPassword(_ password: String) -> Self {
        enterVisiblePasswordText(
            password,
            using: page.repeatPasswordVisibility,
            into: page.visibleRepeatPassword
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
            page.homeTab.waitForExistence(timeout: 15),
            "Home tab was not displayed"
        )
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
