
import XCTest

final class EasyBankSteps {
    private let app: XCUIApplication
    private let page: EasyBankPage

    private let timeout: TimeInterval = 15
    private let shortTimeout: TimeInterval = 2

    init(app: XCUIApplication) {
        self.app = app
        self.page = EasyBankPage(app: app)
    }


    func openLoginFromOnboarding() {
        tap(page.onboardingLoginButton, name: "Onboarding 'Log In' button")
    }

    func openRegistrationFromOnboarding() {
        tap(page.onboardingRegisterButton, name: "Onboarding 'Register' button")
    }


    func enterLoginEmail(_ email: String) {
        type(email, into: page.loginEmailField, name: "Login email field")
    }

    func enterLoginPassword(_ password: String) {
        type(password, into: page.loginPasswordField, name: "Login password field")
    }

    func submitLogin() {
        tapSubmit(page.loginSubmitButton, name: "Login 'Log In' button")
    }

    func login(email: String, password: String) {
        enterLoginEmail(email)
        enterLoginPassword(password)
        submitLogin()
    }

    func assertLoginScreenDisplayed() {
        assertExists(page.loginEmailField, name: "Login email field")
        assertExists(page.loginPasswordField, name: "Login password field")
        assertExists(page.loginSubmitButton, name: "Login 'Log In' button")
    }

    func assertLoginErrorContains(_ fragment: String) {
        let error = page.loginErrorLabel
        assertExists(error, name: "Login error message")
        XCTAssertTrue(
            error.label.contains(fragment),
            "Expected login error to contain '\(fragment)', but it was '\(error.label)'"
        )
    }


    func enterRegistrationEmail(_ email: String) {
        type(email, into: page.registrationEmailField, name: "Registration email field")
    }

    func enterRegistrationPassword(_ password: String) {
        typeIntoPasswordField(password, field: page.registrationPasswordField, name: "Registration password field")
    }

    func enterRegistrationRepeatPassword(_ password: String) {
        typeIntoPasswordField(password, field: page.registrationRepeatPasswordField, name: "Repeat password field")
    }

    func submitRegistration() {
        tapSubmit(page.registrationSubmitButton, name: "Registration 'Register' button")
    }

    func register(email: String, password: String) {
        enterRegistrationEmail(email)
        enterRegistrationPassword(password)
        enterRegistrationRepeatPassword(password)
        submitRegistration()
    }


    func assertHomeDisplayed() {
        dismissSavePasswordPromptIfPresent()
        assertExists(page.sendMoneyButton, name: "Send Money button")
    }

    func logout() {
        tap(page.logoutButton, name: "Logout icon")
        assertExists(page.logoutAlert, name: "'Logging Out' alert")
        tap(page.logoutConfirmButton, name: "Alert 'Yes' button")
    }


    private func assertExists(_ element: XCUIElement, name: String) {
        XCTAssertTrue(
            element.waitForExistence(timeout: timeout),
            "\(name) did not appear within \(Int(timeout)) seconds"
        )
    }

    private func waitUntilHittable(_ element: XCUIElement, name: String) {
        assertExists(element, name: name)
        let hittable = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "hittable == true"),
            object: element
        )
        let result = XCTWaiter().wait(for: [hittable], timeout: timeout)
        XCTAssertEqual(result, .completed, "\(name) is not hittable")
    }


    private func tap(_ element: XCUIElement, name: String) {
        waitUntilHittable(element, name: name)
        element.tap()
    }

    private func type(_ text: String, into field: XCUIElement, name: String) {
        tap(field, name: name)
        field.typeText(text)
    }

    private func typeIntoPasswordField(_ text: String, field: XCUIElement, name: String) {
        tap(field, name: name)
        if dismissStrongPasswordPromptIfPresent() {
            tap(field, name: name)
        }
        clearAutoFilledStrongPasswordIfPresent(in: field)
        field.typeText(text)
    }

    private func clearAutoFilledStrongPasswordIfPresent(in field: XCUIElement) {
        let autoFilled = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "value != nil AND value != '' AND value != placeholderValue"),
            object: field
        )
        guard XCTWaiter().wait(for: [autoFilled], timeout: shortTimeout) == .completed else { return }

        let currentValue = field.value as? String ?? ""
        let deletes = String(repeating: XCUIKeyboardKey.delete.rawValue, count: max(currentValue.count, 1))
        field.typeText(deletes)
    }

    private func tapSubmit(_ button: XCUIElement, name: String) {
        assertExists(button, name: name)
        if !button.isHittable {
            dismissKeyboardIfPresent()
        }
        tap(button, name: name)
    }

    private func dismissKeyboardIfPresent() {
        guard page.keyboard.exists else { return }
        app.typeText("\n")
        let keyboardGone = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == false"),
            object: page.keyboard
        )
        _ = XCTWaiter().wait(for: [keyboardGone], timeout: shortTimeout)
    }
    
    @discardableResult
    private func dismissStrongPasswordPromptIfPresent() -> Bool {
        tapFirstExisting(page.strongPasswordDismissButtons)
    }

    private func dismissSavePasswordPromptIfPresent() {
        tapFirstExisting(page.savePasswordNotNowButtons)
    }

    @discardableResult
    private func tapFirstExisting(_ candidates: [XCUIElement]) -> Bool {
        let perCandidate = shortTimeout / Double(max(candidates.count, 1))
        for button in candidates where button.waitForExistence(timeout: perCandidate) {
            button.tap()
            return true
        }
        return false
    }
}
