import XCTest

final class EasyBankSteps {

    private let page: EasyBankPage
    private let timeout: TimeInterval = 10
    private let systemPromptTimeout: TimeInterval = 2

    init(app: XCUIApplication) {
        page = EasyBankPage(app: app)
    }

    @discardableResult
    func openLogin(file: StaticString = #filePath, line: UInt = #line) -> Self {
        tap(page.onboardingLoginButton, name: "Onboarding Log In button", file: file, line: line)
    }

    @discardableResult
    func openRegistration(file: StaticString = #filePath, line: UInt = #line) -> Self {
        tap(page.onboardingRegisterButton, name: "Onboarding Register button", file: file, line: line)
    }

    @discardableResult
    func enterLoginEmail(_ email: String, file: StaticString = #filePath, line: UInt = #line) -> Self {
        type(email, into: page.loginEmailField, name: "Login email field", file: file, line: line)
    }

    @discardableResult
    func enterLoginPassword(_ password: String, file: StaticString = #filePath, line: UInt = #line) -> Self {
        type(password, into: page.loginPasswordField, name: "Login password field", file: file, line: line)
    }

    @discardableResult
    func submitLogin(file: StaticString = #filePath, line: UInt = #line) -> Self {
        dismissKeyboard()
        return tap(page.loginSubmitButton, name: "Login submit button", file: file, line: line)
    }

    @discardableResult
    func logIn(email: String, password: String, file: StaticString = #filePath, line: UInt = #line) -> Self {
        enterLoginEmail(email, file: file, line: line)
            .enterLoginPassword(password, file: file, line: line)
            .submitLogin(file: file, line: line)
    }

    @discardableResult
    func assertLoginFormDisplayed(file: StaticString = #filePath, line: UInt = #line) -> Self {
        assertExists(page.loginEmailField, name: "Login email field", file: file, line: line)
    }

    @discardableResult
    func assertLoginErrorContains(_ fragment: String, file: StaticString = #filePath, line: UInt = #line) -> Self {
        guard page.loginErrorLabel.waitForExistence(timeout: timeout) else {
            XCTFail("Login error message did not appear", file: file, line: line)
            return self
        }
        XCTAssertTrue(
            page.loginErrorLabel.label.localizedCaseInsensitiveContains(fragment),
            "Expected login error to contain '\(fragment)' but was '\(page.loginErrorLabel.label)'",
            file: file,
            line: line
        )
        return self
    }

    @discardableResult
    func enterRegistrationEmail(_ email: String, file: StaticString = #filePath, line: UInt = #line) -> Self {
        type(email, into: page.registrationEmailField, name: "Registration email field", file: file, line: line)
    }

    @discardableResult
    func enterRegistrationPassword(_ password: String, file: StaticString = #filePath, line: UInt = #line) -> Self {
        type(password, into: page.registrationPasswordField, name: "Registration password field",
             isNewPassword: true, file: file, line: line)
    }

    @discardableResult
    func enterRepeatPassword(_ password: String, file: StaticString = #filePath, line: UInt = #line) -> Self {
        type(password, into: page.registrationRepeatPasswordField, name: "Repeat password field",
             isNewPassword: true, file: file, line: line)
    }

    @discardableResult
    func submitRegistration(file: StaticString = #filePath, line: UInt = #line) -> Self {
        dismissKeyboard()
        return tap(page.registrationSubmitButton, name: "Registration submit button", file: file, line: line)
    }

    @discardableResult
    func register(email: String, password: String, file: StaticString = #filePath, line: UInt = #line) -> Self {
        enterRegistrationEmail(email, file: file, line: line)
            .enterRegistrationPassword(password, file: file, line: line)
            .enterRepeatPassword(password, file: file, line: line)
            .submitRegistration(file: file, line: line)
    }

    @discardableResult
    func assertHomeDisplayed(file: StaticString = #filePath, line: UInt = #line) -> Self {
        assertExists(page.homeTab, name: "Home tab", file: file, line: line)
            .assertExists(page.sendMoneyButton, name: "Send Money button", file: file, line: line)
    }

    @discardableResult
    func logOut(file: StaticString = #filePath, line: UInt = #line) -> Self {
        tap(page.logoutButton, name: "Logout button", file: file, line: line)
        guard page.logoutAlert.waitForExistence(timeout: timeout) else {
            XCTFail("Logout confirmation alert did not appear", file: file, line: line)
            return self
        }
        return tap(page.logoutConfirmButton, name: "Logout confirm (Yes) button", file: file, line: line)
    }

    @discardableResult
    private func tap(_ element: XCUIElement, name: String, file: StaticString, line: UInt) -> Self {
        guard waitUntilHittable(element) else {
            XCTFail("\(name) did not become hittable within \(Int(timeout))s", file: file, line: line)
            return self
        }
        element.tap()
        return self
    }

    @discardableResult
    private func type(_ text: String,
                      into element: XCUIElement,
                      name: String,
                      isNewPassword: Bool = false,
                      file: StaticString,
                      line: UInt) -> Self {
        guard waitUntilHittable(element) else {
            XCTFail("\(name) did not become hittable within \(Int(timeout))s", file: file, line: line)
            return self
        }
        element.tap()
        if isNewPassword {
            dismissStrongPasswordPromptIfPresent()
            enterByKeyTaps(text, into: element, name: name, file: file, line: line)
        } else {
            clearText(in: element)
            element.typeText(text)
        }
        return self
    }

    @discardableResult
    private func assertExists(_ element: XCUIElement, name: String, file: StaticString, line: UInt) -> Self {
        XCTAssertTrue(element.waitForExistence(timeout: timeout),
                      "\(name) was not displayed within \(Int(timeout))s",
                      file: file, line: line)
        return self
    }

    private func waitUntilHittable(_ element: XCUIElement) -> Bool {
        guard element.waitForExistence(timeout: timeout) else { return false }
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "isHittable == true"),
            object: element
        )
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }

    private func enterByKeyTaps(_ text: String, into element: XCUIElement, name: String, file: StaticString, line: UInt) {
        for character in text {
            let key = page.keyboardKey(String(character))
            guard key.waitForExistence(timeout: timeout) else {
                XCTFail("Keyboard key '\(character)' not found; new passwords must use lowercase letters only",
                        file: file, line: line)
                return
            }
            key.tap()
        }
        XCTAssertEqual(typedCount(in: element), text.count,
                       "\(name) did not keep the typed password", file: file, line: line)
    }

    private func typedCount(in element: XCUIElement) -> Int {
        guard let value = element.value as? String, value != element.placeholderValue else { return 0 }
        return value.count
    }

    private func clearText(in element: XCUIElement) {
        guard let current = element.value as? String,
              !current.isEmpty,
              current != element.placeholderValue else { return }
        element.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: current.count))
    }

    private func dismissStrongPasswordPromptIfPresent() {
        if page.strongPasswordCloseButton.waitForExistence(timeout: systemPromptTimeout) {
            page.strongPasswordCloseButton.tap()
        }
    }

    private func dismissKeyboard() {
        if page.keyboardReturnKey.exists {
            page.keyboardReturnKey.tap()
        }
    }
}