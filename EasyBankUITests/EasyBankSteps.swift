import XCTest

final class EasyBankSteps {
    private let page: EasyBankPage
    private let timeout: TimeInterval = 10

    init(app: XCUIApplication) {
        self.page = EasyBankPage(app: app)
    }


    private func waitUntilHittable(_ element: XCUIElement,
                                   file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(element.waitForExistence(timeout: timeout),
                      "ელემენტი ვერ გამოჩნდა: \(element)", file: file, line: line)
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "isHittable == true"),
            object: element
        )
        XCTAssertEqual(XCTWaiter().wait(for: [expectation], timeout: timeout), .completed,
                       "ელემენტი დასაჭერად მზად არ არის: \(element)",
                       file: file, line: line)
    }

    private func tap(_ element: XCUIElement,
                     file: StaticString = #filePath, line: UInt = #line) {
        waitUntilHittable(element, file: file, line: line)
        element.tap()
    }

    private func dismissStrongPasswordPromptIfNeeded() {
        let close = page.strongPasswordCloseButton
        if close.waitForExistence(timeout: 2) {
            close.tap()
        }
    }

    private func type(_ text: String, into field: XCUIElement,
                      isPassword: Bool = false,
                      file: StaticString = #filePath, line: UInt = #line) {
        tap(field, file: file, line: line)
        if isPassword {
            dismissStrongPasswordPromptIfNeeded()
        }
        field.typeText(text)
    }

    func openLogin() { tap(page.onboardingLoginButton) }
    func openRegistration() { tap(page.onboardingRegisterButton) }

    func enterLoginEmail(_ email: String) {
        type(email, into: page.loginEmailField)
    }
    func enterLoginPassword(_ password: String) {
        type(password, into: page.loginPasswordField, isPassword: true)
    }
    func submitLogin() { tap(page.loginSubmitButton) }

    func enterRegistrationEmail(_ email: String) {
        type(email, into: page.registrationEmailField)
    }
    func enterRegistrationPassword(_ password: String) {
        type(password, into: page.registrationPasswordField, isPassword: true)
    }
    func enterRegistrationRepeatPassword(_ password: String) {
        type(password, into: page.registrationRepeatPasswordField, isPassword: true)
    }
    func submitRegistration() { tap(page.registrationSubmitButton) }


    func logIn(email: String, password: String) {
        openLogin()
        logInFromLoginForm(email: email, password: password)
    }

    func logInFromLoginForm(email: String, password: String) {
        enterLoginEmail(email)
        enterLoginPassword(password)
        submitLogin()
    }

    func register(email: String, password: String) {
        openRegistration()
        enterRegistrationEmail(email)
        enterRegistrationPassword(password)
        enterRegistrationRepeatPassword(password)
        submitRegistration()
    }

    func logOut() {
        tap(page.logoutButton)
        XCTAssertTrue(page.logoutAlert.waitForExistence(timeout: timeout),
                      "Logging Out დიალოგი არ გამოჩნდა")
        tap(page.logoutAlertYesButton)
    }


    func assertLoginErrorContainsAny(of fragments: [String],
                                     file: StaticString = #filePath, line: UInt = #line) {
        let error = page.loginErrorText
        XCTAssertTrue(error.waitForExistence(timeout: timeout),
                      "ავტორიზაციის შეცდომა არ გამოჩნდა", file: file, line: line)

        let subpredicates = fragments.map {
            NSPredicate(format: "label CONTAINS[c] %@", $0)
        }
        let expectation = XCTNSPredicateExpectation(
            predicate: NSCompoundPredicate(orPredicateWithSubpredicates: subpredicates),
            object: error
        )
        XCTAssertEqual(XCTWaiter().wait(for: [expectation], timeout: timeout), .completed,
                       "შეცდომის ტექსტი \"\(error.label)\" არ შეიცავს არცერთ ფრაგმენტს: \(fragments)",
                       file: file, line: line)
    }

    func assertMainScreenDisplayed(file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(page.sendMoneyButton.waitForExistence(timeout: timeout),
                      "Send Money ღილაკი არ გამოჩნდა", file: file, line: line)
        XCTAssertTrue(page.homeTab.exists,
                      "Home ჩანართი არ გამოჩნდა", file: file, line: line)
    }

    // MARK: ტესტ-მონაცემები
    static func uniqueEmail() -> String {
        "uitest.\(UUID().uuidString.prefix(8).lowercased())@example.com"
    }
}