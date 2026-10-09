import XCTest

class EasyBankSteps: EasyBankPage {
    private let timeout: TimeInterval = 15

    func waitAndTap(_ element: XCUIElement, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(element.waitForExistence(timeout: timeout), "\(element) not found", file: file, line: line)
        element.tap()
    }

    func enter(_ text: String, into element: XCUIElement, file: StaticString = #filePath, line: UInt = #line) {
        waitAndTap(element, file: file, line: line)
        element.typeText(text)
    }

    func scrollAndTapSettingsRow(_ row: XCUIElement) {
        var swipes = 0
        while !row.waitForExistence(timeout: 2) && swipes < 3 {
            settingsApp.swipeUp()
            swipes += 1
        }
        waitAndTap(row)
    }

    func disablePasswordAutoFill() {
        settingsApp.launch()
        if !settingsAutoFillSwitch.waitForExistence(timeout: 3) {
            if !settingsAutoFillRow.waitForExistence(timeout: 3) {
                waitAndTap(settingsGeneralRow)
            }
            scrollAndTapSettingsRow(settingsAutoFillRow)
        }
        XCTAssertTrue(settingsAutoFillSwitch.waitForExistence(timeout: timeout), "AutoFill switch not found in Settings")
        if settingsAutoFillSwitch.value as? String == "1" {
            settingsAutoFillSwitch.coordinate(withNormalizedOffset: CGVector(dx: 0.92, dy: 0.5)).tap()
            let switchedOff = XCTNSPredicateExpectation(predicate: NSPredicate(format: "value == '0'"), object: settingsAutoFillSwitch)
            XCTAssertEqual(XCTWaiter.wait(for: [switchedOff], timeout: timeout), .completed, "AutoFill switch was not turned off")
        }
        settingsApp.terminate()
        app.activate()
    }

    func dismissStrongPasswordPromptIfPresent() -> Bool {
        for button in strongPasswordCloseButtons where button.waitForExistence(timeout: 2) {
            button.tap()
            return true
        }
        return false
    }

    func enterRegistrationPassword(_ text: String, into element: XCUIElement) {
        waitAndTap(element)
        if dismissStrongPasswordPromptIfPresent() {
            element.tap()
        }
        element.typeText(text)
    }

    func openLoginForm() {
        waitAndTap(onboardingLoginButton)
    }

    func openRegistrationForm() {
        waitAndTap(onboardingRegisterButton)
    }

    func submitLogin(email: String, password: String) {
        enter(email, into: loginEmailField)
        enter(password, into: loginPasswordField)
        waitAndTap(loginSubmitButton)
    }

    func submitRegistration(email: String, password: String) {
        enter(email, into: registrationEmailField)
        enterRegistrationPassword(password, into: registrationPasswordField)
        enterRegistrationPassword(password, into: registrationRepeatPasswordField)
        waitAndTap(registrationSubmitButton)
    }

    func logOut() {
        waitAndTap(logoutButton)
        waitAndTap(logoutConfirmButton)
    }

    func verifyLoginError(contains fragment: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(loginErrorText.waitForExistence(timeout: timeout), "Login error is not displayed", file: file, line: line)
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", fragment)
        let labelExpectation = XCTNSPredicateExpectation(predicate: predicate, object: loginErrorText)
        let result = XCTWaiter.wait(for: [labelExpectation], timeout: timeout)
        XCTAssertEqual(result, .completed, "Expected '\(fragment)' in '\(loginErrorText.label)'", file: file, line: line)
    }

    func verifyHomeScreenDisplayed(file: StaticString = #filePath, line: UInt = #line) {
        let isHomeDisplayed = sendMoneyButton.waitForExistence(timeout: timeout)
        let registrationError = registrationErrorText.exists ? registrationErrorText.label : "none"
        XCTAssertTrue(isHomeDisplayed, "Send Money button is not displayed, registration error: \(registrationError)", file: file, line: line)
        XCTAssertTrue(homeTabButton.exists, "Home tab is not displayed", file: file, line: line)
    }

    func verifyLoginFormDisplayed(file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(loginEmailField.waitForExistence(timeout: timeout), "Login form is not displayed", file: file, line: line)
    }

    func uniqueEmail() -> String {
        "qa.\(UUID().uuidString.lowercased())@example.com"
    }
}
