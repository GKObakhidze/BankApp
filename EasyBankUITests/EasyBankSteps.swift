import XCTest

final class EasyBankSteps {
    private let page: EasyBankPage
    private let timeout: TimeInterval = 10

    private enum UIError: Error {
        case elementUnavailable(String)
    }

    init(page: EasyBankPage) {
        self.page = page
    }

    func assertOnboardingDisplayed() throws {
        try waitUntilHittable(page.onboardingLogin)
        try waitUntilHittable(page.onboardingRegister)
    }

    func openLogin() throws {
        try tap(page.onboardingLogin)
        try assertLoginDisplayed()
    }

    func openRegistration() throws {
        try tap(page.onboardingRegister)
        try waitUntilHittable(page.registrationEmail)
    }

    func logIn(email: String, password: String) throws {
        try enterText(email, into: page.loginEmail)
        try enterText(password, into: page.loginPassword, isPassword: true)
        try tap(page.loginSubmit)
    }

    func register(email: String, password: String) throws {
        try enterText(email, into: page.registrationEmail)
        try enterText(password, into: page.registrationPassword, isPassword: true)
        try enterText(password, into: page.registrationRepeatPassword, isPassword: true)
        try tap(page.registrationSubmit)
    }

    func assertAuthenticationError(containing fragment: String) throws {
        try waitForExistence(page.loginError)
        let messageDisplayed = NSPredicate { object, _ in
            guard let element = object as? XCUIElement else { return false }
            return element.exists && element.isHittable && element.label.contains(fragment)
        }
        try wait(for: messageDisplayed, on: page.loginError,
                 description: "Visible authentication error containing '\(fragment)'")
        XCTAssertTrue(page.loginError.label.contains(fragment))
    }

    func assertHomeDisplayed() throws {
        try waitUntilHittable(page.homeTab)
        try waitUntilHittable(page.sendMoney)
        XCTAssertTrue(page.homeTab.isSelected)
    }

    func logOut() throws {
        try tap(page.logout)
        try waitForExistence(page.logoutConfirmation)
        try tap(page.confirmLogout)
        try assertLoginDisplayed()
    }

    private func assertLoginDisplayed() throws {
        try waitUntilHittable(page.loginEmail)
        try waitForExistence(page.loginPassword)
        try waitForExistence(page.loginSubmit)
    }

    private func enterText(_ text: String, into field: XCUIElement,
                           isPassword: Bool = false) throws {
        try tap(field)
        if isPassword {
            try dismissStrongPasswordPromptIfPresent()
        }
        try waitUntilHittable(field)
        if let value = field.value as? String, !value.isEmpty {
            field.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: value.count))
        }
        field.typeText(text)
    }

    private func dismissStrongPasswordPromptIfPresent() throws {
        if page.strongPasswordClose.waitForExistence(timeout: 1) {
            try tap(page.strongPasswordClose)
        } else if page.systemStrongPasswordClose.waitForExistence(timeout: 1) {
            try tap(page.systemStrongPasswordClose)
        }
    }

    private func tap(_ element: XCUIElement) throws {
        try waitUntilHittable(element)
        element.tap()
    }

    private func waitForExistence(_ element: XCUIElement) throws {
        guard element.waitForExistence(timeout: timeout) else {
            XCTFail("Element did not appear: \(element)")
            throw UIError.elementUnavailable(element.description)
        }
    }

    private func waitUntilHittable(_ element: XCUIElement) throws {
        try waitForExistence(element)
        let hittable = NSPredicate { object, _ in
            guard let element = object as? XCUIElement else { return false }
            return element.exists && element.isHittable
        }
        try wait(for: hittable, on: element, description: "Hittable element: \(element)")
    }

    private func wait(for predicate: NSPredicate, on element: XCUIElement,
                      description: String) throws {
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
            XCTFail("Timed out waiting for \(description)")
            throw UIError.elementUnavailable(description)
        }
    }
}
