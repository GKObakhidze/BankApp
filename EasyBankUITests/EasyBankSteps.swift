

import UIKit
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

        let expectedValue = String(repeating: "•", count: text.count)

    
        let strategies: [(name: String, enter: () -> Void)] = [
            ("typing", { field.typeText(text) }),
            ("paste", { self.paste(text, into: field, name: name) }),
            ("paste retry", { self.paste(text, into: field, name: name) })
        ]

        for (index, strategy) in strategies.enumerated() {
            focusIfNeeded(field, name: name)
            clearFieldIfNotEmpty(field)
            strategy.enter()

            if waitForValue(of: field, toEqual: expectedValue) {
                return
            }
            attachDiagnostics(
                named: "\(name) - attempt \(index + 1) (\(strategy.name))",
                field: field
            )
        }

        XCTFail("\(name) does not contain the entered password. Current value: '\(field.value ?? "nil")'")
    }

    private func paste(_ text: String, into field: XCUIElement, name: String) {
        UIPasteboard.general.string = text
        focusIfNeeded(field, name: name)

        field.tap()
        if !tapFirstExisting(page.pasteMenuItems) {
            field.press(forDuration: 1.0)
            XCTAssertTrue(tapFirstExisting(page.pasteMenuItems), "'Paste' menu did not appear for \(name)")
        }
    }

    private func focusIfNeeded(_ field: XCUIElement, name: String) {
        let hasFocus = (field.value(forKey: "hasKeyboardFocus") as? Bool) ?? false
        if !hasFocus {
            tap(field, name: name)
        }
    }

    private func clearFieldIfNotEmpty(_ field: XCUIElement) {
        let currentValue = field.value as? String ?? ""
        guard !currentValue.isEmpty, currentValue != field.placeholderValue else { return }
        let deletes = String(repeating: XCUIKeyboardKey.delete.rawValue, count: currentValue.count + 1)
        field.typeText(deletes)
    }

    private func waitForValue(of field: XCUIElement, toEqual expected: String) -> Bool {
        let valueMatches = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "value == %@", expected),
            object: field
        )
        return XCTWaiter().wait(for: [valueMatches], timeout: shortTimeout) == .completed
    }

    private func attachDiagnostics(named name: String, field: XCUIElement) {
        print("[EasyBankSteps] \(name): field value = '\(field.value ?? "nil")'")
        print(app.debugDescription)

        XCTContext.runActivity(named: "Diagnostics: \(name)") { activity in
            let screenshot = XCTAttachment(screenshot: app.screenshot())
            screenshot.name = "\(name) - screen"
            screenshot.lifetime = .keepAlways
            activity.add(screenshot)

            let tree = XCTAttachment(string: app.debugDescription)
            tree.name = "\(name) - UI tree"
            tree.lifetime = .keepAlways
            activity.add(tree)
        }
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
