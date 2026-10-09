//
//  EasyBankSteps.swift
//  EasyBankUITests
//
//  All UI actions, waits/synchronization, assertions and reusable flows.
//

import XCTest

final class EasyBankSteps {
    private let app: XCUIApplication
    private let page: EasyBankPage
    private let defaultTimeout: TimeInterval = 20

    init(app: XCUIApplication) {
        self.app = app
        self.page = EasyBankPage(app: app)
    }

    // MARK: - Synchronization helpers

    @discardableResult
    private func waitForExistence(_ element: XCUIElement,
                                  _ name: String,
                                  timeout: TimeInterval? = nil,
                                  file: StaticString = #filePath,
                                  line: UInt = #line) -> XCUIElement {
        XCTAssertTrue(element.waitForExistence(timeout: timeout ?? defaultTimeout),
                      "\(name) did not appear within the timeout.",
                      file: file, line: line)
        return element
    }

    @discardableResult
    private func waitUntilHittable(_ element: XCUIElement,
                                   _ name: String,
                                   timeout: TimeInterval? = nil,
                                   file: StaticString = #filePath,
                                   line: UInt = #line) -> XCUIElement {
        waitForExistence(element, name, timeout: timeout, file: file, line: line)

        let hittable = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "isHittable == true"),
            object: element
        )
        let result = XCTWaiter().wait(for: [hittable], timeout: timeout ?? defaultTimeout)
        XCTAssertEqual(result, .completed, "\(name) never became hittable.", file: file, line: line)
        return element
    }

    private func waitUntilGone(_ element: XCUIElement,
                               _ name: String,
                               timeout: TimeInterval? = nil,
                               file: StaticString = #filePath,
                               line: UInt = #line) {
        let gone = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == false"),
            object: element
        )
        let result = XCTWaiter().wait(for: [gone], timeout: timeout ?? defaultTimeout)
        XCTAssertEqual(result, .completed, "\(name) was still displayed.", file: file, line: line)
    }

    // MARK: - Generic interactions

    private func tap(_ element: XCUIElement, _ name: String,
                     file: StaticString = #filePath, line: UInt = #line) {
        waitUntilHittable(element, name, file: file, line: line).tap()
    }

    /// The app's fields are UIKit text fields bridged into SwiftUI, and a binding update that is
    /// still in flight can overwrite freshly typed characters. Type the whole value, wait for the
    /// field to report it back, and type it again if characters were dropped.
    private func type(_ text: String, into element: XCUIElement, _ name: String,
                      attempts: Int = 2,
                      file: StaticString = #filePath, line: UInt = #line) {
        tap(element, name, file: file, line: line)
        dismissStrongPasswordPromptIfPresent()
        waitUntilHittable(element, name, file: file, line: line)

        for _ in 1...attempts {
            element.typeText(text)
            if waitForValue(element, equals: text) { return }
            clearCurrentValue(of: element)
        }

        XCTFail("\(name) did not accept the typed value. Expected \"\(text)\", found \"\(currentValue(of: element))\".",
                file: file, line: line)
    }

    /// A password field masks its value, so the check compares the number of bullets it reports
    /// with the number of characters that were typed.
    private func typePassword(_ password: String, into element: XCUIElement, _ name: String,
                              attempts: Int = 2,
                              file: StaticString = #filePath, line: UInt = #line) {
        tap(element, name, file: file, line: line)
        dismissStrongPasswordPromptIfPresent()
        waitUntilHittable(element, name, file: file, line: line)

        let masked = String(repeating: "•", count: password.count)
        for _ in 1...attempts {
            element.typeText(password)
            if waitForValue(element, equals: masked) { return }
            clearCurrentValue(of: element)
        }

        XCTFail("\(name) did not accept the typed value. Expected \(password.count) characters, found \(currentValue(of: element).count).",
                file: file, line: line)
    }

    @discardableResult
    private func waitForValue(_ element: XCUIElement, equals expected: String,
                              timeout: TimeInterval = 5) -> Bool {
        let matches = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "value == %@", expected),
            object: element
        )
        return XCTWaiter().wait(for: [matches], timeout: timeout) == .completed
    }

    /// An empty UIKit text field reports its placeholder as the accessibility value.
    private func currentValue(of element: XCUIElement) -> String {
        let value = (element.value as? String) ?? ""
        return value == element.placeholderValue ? "" : value
    }

    private func clearCurrentValue(of element: XCUIElement) {
        let length = currentValue(of: element).count
        guard length > 0 else { return }
        element.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: length))
    }

    func dismissKeyboardIfPresent() {
        guard page.keyboard.exists else { return }
        if page.keyboardReturnKey.exists && page.keyboardReturnKey.isHittable {
            page.keyboardReturnKey.tap()
        } else {
            app.swipeDown()
        }
    }

    /// The system "Use Strong Password?" sheet belongs to SpringBoard and can block typing.
    func dismissStrongPasswordPromptIfPresent() {
        for label in page.strongPasswordDismissLabels {
            let button = page.strongPasswordDismissButton(labeled: label)
            if button.waitForExistence(timeout: 1) && button.isHittable {
                button.tap()
                return
            }
        }
    }

    // MARK: - Onboarding steps

    func assertOnboardingDisplayed(file: StaticString = #filePath, line: UInt = #line) {
        waitForExistence(page.onboardingLoginButton, "Onboarding Log In button", file: file, line: line)
    }

    func tapLoginOnOnboarding(file: StaticString = #filePath, line: UInt = #line) {
        tap(page.onboardingLoginButton, "Onboarding Log In button", file: file, line: line)
    }

    func tapRegisterOnOnboarding(file: StaticString = #filePath, line: UInt = #line) {
        tap(page.onboardingRegisterButton, "Onboarding Register button", file: file, line: line)
    }

    // MARK: - Login steps

    func assertLoginFormDisplayed(file: StaticString = #filePath, line: UInt = #line) {
        waitForExistence(page.loginEmailField, "Login email field", file: file, line: line)
        waitForExistence(page.loginSubmitButton, "Login submit button", file: file, line: line)
    }

    func enterLoginEmail(_ email: String, file: StaticString = #filePath, line: UInt = #line) {
        type(email, into: page.loginEmailField, "Login email field", file: file, line: line)
    }

    func enterLoginPassword(_ password: String, file: StaticString = #filePath, line: UInt = #line) {
        typePassword(password, into: page.loginPasswordField, "Login password field", file: file, line: line)
    }

    func submitLogin(file: StaticString = #filePath, line: UInt = #line) {
        dismissKeyboardIfPresent()
        tap(page.loginSubmitButton, "Login submit button", file: file, line: line)
    }

    /// Reusable flow: fill the login form and submit it.
    func logIn(email: String, password: String,
               file: StaticString = #filePath, line: UInt = #line) {
        assertLoginFormDisplayed(file: file, line: line)
        enterLoginEmail(email, file: file, line: line)
        enterLoginPassword(password, file: file, line: line)
        submitLogin(file: file, line: line)
    }

    func assertLoginErrorContains(_ fragment: String,
                                  file: StaticString = #filePath, line: UInt = #line) {
        let error = waitForExistence(page.loginErrorLabel, "Login error message", file: file, line: line)
        let text = error.label
        XCTAssertTrue(text.localizedCaseInsensitiveContains(fragment),
                      "Expected the login error to contain \"\(fragment)\", but it was \"\(text)\".",
                      file: file, line: line)
    }

    // MARK: - Registration steps

    func assertRegistrationFormDisplayed(file: StaticString = #filePath, line: UInt = #line) {
        waitForExistence(page.registrationEmailField, "Registration email field", file: file, line: line)
        waitForExistence(page.registrationSubmitButton, "Registration submit button", file: file, line: line)
    }

    func enterRegistrationEmail(_ email: String, file: StaticString = #filePath, line: UInt = #line) {
        type(email, into: page.registrationEmailField, "Registration email field", file: file, line: line)
    }

    func enterRegistrationPassword(_ password: String, file: StaticString = #filePath, line: UInt = #line) {
        typePassword(password, into: page.registrationPasswordField, "Registration password field", file: file, line: line)
    }

    func enterRegistrationRepeatPassword(_ password: String, file: StaticString = #filePath, line: UInt = #line) {
        typePassword(password, into: page.registrationRepeatPasswordField, "Registration repeat password field", file: file, line: line)
    }

    func submitRegistration(file: StaticString = #filePath, line: UInt = #line) {
        dismissKeyboardIfPresent()
        tap(page.registrationSubmitButton, "Registration submit button", file: file, line: line)
    }

    /// Reusable flow: fill the registration form and submit it.
    ///
    /// The repeat field is filled before the password field. The registration form writes its
    /// validation flags back while a field is being edited, and with the opposite order the
    /// password field loses every keystroke but the last one.
    func register(email: String, password: String,
                  file: StaticString = #filePath, line: UInt = #line) {
        assertRegistrationFormDisplayed(file: file, line: line)
        enterRegistrationEmail(email, file: file, line: line)
        enterRegistrationRepeatPassword(password, file: file, line: line)
        enterRegistrationPassword(password, file: file, line: line)
        submitRegistration(file: file, line: line)
    }

    // MARK: - Home steps

    func assertMainScreenDisplayed(file: StaticString = #filePath, line: UInt = #line) {
        waitForExistence(page.homeSendMoneyButton, "Home Send Money button", file: file, line: line)
        XCTAssertTrue(page.homeTab.exists, "The Home tab was not displayed.", file: file, line: line)
    }

    func tapLogout(file: StaticString = #filePath, line: UInt = #line) {
        tap(page.homeLogoutButton, "Home logout button", file: file, line: line)
    }

    func confirmLogout(file: StaticString = #filePath, line: UInt = #line) {
        waitForExistence(page.logoutAlert, "Logout confirmation alert", file: file, line: line)
        tap(page.logoutConfirmButton, "Logout alert Yes button", file: file, line: line)
        waitUntilGone(page.logoutAlert, "Logout confirmation alert", file: file, line: line)
    }

    /// Reusable flow: log out from Home and confirm the alert.
    func logOut(file: StaticString = #filePath, line: UInt = #line) {
        tapLogout(file: file, line: line)
        confirmLogout(file: file, line: line)
    }
}
