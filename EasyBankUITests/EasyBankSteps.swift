//
//  EasyBankSteps.swift
//  EasyBankUITests
//

import XCTest

final class EasyBankSteps {
    private static let timeout: TimeInterval = 15
    // Long enough for iOS to raise the optional Strong Password suggestion, short enough not to
    // slow down the iOS versions that never show it.
    private static let systemPromptTimeout: TimeInterval = 3

    private let page: EasyBankPage

    init(app: XCUIApplication) {
        page = EasyBankPage(app: app)
    }

    // MARK: - Onboarding

    @discardableResult
    func openLoginForm() -> EasyBankSteps {
        step("Open the login form from onboarding") {
            tap(page.onboardingLoginButton, named: "Onboarding Log In button")
            waitFor(page.loginEmailField, named: "Login email field")
        }
    }

    @discardableResult
    func openRegistrationForm() -> EasyBankSteps {
        step("Open the registration form from onboarding") {
            tap(page.onboardingRegisterButton, named: "Onboarding Register button")
            waitFor(page.registrationEmailField, named: "Registration email field")
        }
    }

    // MARK: - Login

    @discardableResult
    func enterLoginEmail(_ email: String) -> EasyBankSteps {
        step("Enter the login email \(email)") {
            replaceText(in: page.loginEmailField, named: "Login email field", with: email)
        }
    }

    @discardableResult
    func enterLoginPassword(_ password: String) -> EasyBankSteps {
        step("Enter the login password") {
            replaceText(in: page.loginPasswordField, named: "Login password field", with: password)
        }
    }

    @discardableResult
    func submitLogin() -> EasyBankSteps {
        step("Submit the login form") {
            tap(page.loginSubmitButton, named: "Login submit button")
        }
    }

    @discardableResult
    func logIn(email: String, password: String) -> EasyBankSteps {
        enterLoginEmail(email)
            .enterLoginPassword(password)
            .submitLogin()
    }

    @discardableResult
    func validateLoginError(contains fragment: String) -> EasyBankSteps {
        step("Validate that the login error mentions '\(fragment)'") {
            // The error only appears once authentication has answered, so the wait is on the
            // message itself rather than on the element merely existing.
            wait(for: NSPredicate(format: "exists == true AND label CONTAINS[c] %@", fragment),
                 on: page.loginErrorText,
                 named: "a login error containing '\(fragment)'")
            XCTAssertTrue(page.loginErrorText.label.localizedCaseInsensitiveContains(fragment),
                          "Login error was '\(page.loginErrorText.label)', expected it to contain '\(fragment)'")
            attachScreenshot(named: "Login error")
        }
    }

    // MARK: - Registration

    @discardableResult
    func enterRegistrationEmail(_ email: String) -> EasyBankSteps {
        step("Enter the registration email \(email)") {
            replaceText(in: page.registrationEmailField, named: "Registration email field", with: email)
        }
    }

    @discardableResult
    func enterRegistrationPassword(_ password: String) -> EasyBankSteps {
        step("Enter the registration password") {
            replaceText(in: page.registrationPasswordField, named: "Registration password field",
                        with: password, dismissingStrongPasswordPrompt: true)
        }
    }

    @discardableResult
    func enterRepeatPassword(_ password: String) -> EasyBankSteps {
        step("Repeat the registration password") {
            replaceText(in: page.registrationRepeatPasswordField, named: "Repeat password field",
                        with: password, dismissingStrongPasswordPrompt: true)
        }
    }

    @discardableResult
    func submitRegistration() -> EasyBankSteps {
        step("Submit the registration form") {
            // The form has no scroll view and the keyboard is still up after the last password,
            // so the button is only tapped once it is actually reachable rather than just present.
            waitUntilHittable(page.registrationSubmitButton, named: "Registration submit button")
            page.registrationSubmitButton.tap()
        }
    }

    @discardableResult
    func register(email: String, password: String) -> EasyBankSteps {
        enterRegistrationEmail(email)
            .enterRegistrationPassword(password)
            .enterRepeatPassword(password)
            .submitRegistration()
    }

    // MARK: - Home

    @discardableResult
    func validateHomeIsDisplayed() -> EasyBankSteps {
        step("Validate that the Home screen is displayed") {
            XCTAssertTrue(page.sendMoneyButton.waitForExistence(timeout: Self.timeout),
                          "Home screen did not appear within \(Int(Self.timeout)) seconds.\(registrationErrorHint())")
            waitFor(page.homeTabButton, named: "Home tab")
            attachScreenshot(named: "Home screen")
        }
    }

    @discardableResult
    func logOut() -> EasyBankSteps {
        step("Log out and confirm") {
            tap(page.logoutButton, named: "Log Out button")
            waitFor(page.logoutAlert, named: "Logging Out alert")
            tap(page.logoutConfirmButton, named: "Yes button in the Logging Out alert")
            // Confirming the logout lands on the login form, not on onboarding.
            waitFor(page.loginEmailField, named: "Login email field after logging out")
        }
    }

    // MARK: - Shared actions and synchronisation

    @discardableResult
    private func step(_ name: String, _ body: () -> Void) -> EasyBankSteps {
        XCTContext.runActivity(named: name) { _ in body() }

        return self
    }

    private func tap(_ element: XCUIElement, named name: String) {
        waitFor(element, named: name)
        element.tap()
    }

    private func replaceText(in field: XCUIElement, named name: String, with text: String,
                             dismissingStrongPasswordPrompt: Bool = false) {
        tap(field, named: name)

        if dismissingStrongPasswordPrompt
            && page.strongPasswordCloseButton.waitForExistence(timeout: Self.systemPromptTimeout) {
            page.strongPasswordCloseButton.tap()
            // Closing the suggestion can take the focus away from the field.
            tap(field, named: name)
        }

        // An empty field reports its placeholder as its value, so only real text is cleared.
        if let current = field.value as? String, !current.isEmpty, current != field.placeholderValue {
            field.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: current.count))
        }
        field.typeText(text)
    }

    private func waitFor(_ element: XCUIElement, named name: String) {
        XCTAssertTrue(element.waitForExistence(timeout: Self.timeout),
                      "\(name) did not appear within \(Int(Self.timeout)) seconds")
    }

    private func waitUntilHittable(_ element: XCUIElement, named name: String) {
        wait(for: NSPredicate(format: "exists == true AND isHittable == true"),
             on: element,
             named: "\(name) to become hittable")
    }

    private func wait(for predicate: NSPredicate, on element: XCUIElement, named name: String) {
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: Self.timeout)

        XCTAssertEqual(result, .completed, "Timed out after \(Int(Self.timeout)) seconds waiting for \(name)")
    }

    private func registrationErrorHint() -> String {
        page.registrationErrorText.exists ? " Registration error shown: '\(page.registrationErrorText.label)'." : ""
    }

    private func attachScreenshot(named name: String) {
        XCTContext.runActivity(named: "Screenshot: \(name)") { activity in
            let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
            attachment.name = name
            attachment.lifetime = .keepAlways
            activity.add(attachment)
        }
    }
}
