
import XCTest

final class EasyBankSteps {

    let page: EasyBankPage

    init(app: XCUIApplication) {
        self.page = EasyBankPage(app: app)
    }



    private func waitForHittable(
        _ element: XCUIElement,
        timeout: TimeInterval = 10
    ) {
        XCTAssertTrue(
            element.waitForExistence(timeout: timeout),
            "Element was not found"
        )

        let predicate = NSPredicate(
            format: "hittable == true"
        )

        let expectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: element
        )

        let result = XCTWaiter.wait(
            for: [expectation],
            timeout: timeout
        )

        XCTAssertEqual(
            result,
            .completed,
            "Element is not hittable"
        )
    }


    func openLogin() {
        let button = page.onboardingLoginButton

        XCTAssertTrue(
            button.waitForExistence(timeout: 10),
            "Onboarding login button was not found"
        )

        button.tap()
    }

    func enterEmail(_ email: String) {
        let emailField = page.loginEmailField

        XCTAssertTrue(
            emailField.waitForExistence(timeout: 10),
            "Login email field was not found"
        )

        emailField.tap()
        emailField.typeText(email)
    }

    func enterPassword(_ password: String) {
        let passwordField = page.loginPasswordField

        XCTAssertTrue(
            passwordField.waitForExistence(timeout: 10),
            "Login password field was not found"
        )

        passwordField.tap()
        passwordField.typeText(password)
    }

    func submitLogin() {
        let button = page.loginSubmitButton

        XCTAssertTrue(
            button.waitForExistence(timeout: 10),
            "Login submit button was not found"
        )

        if !button.isHittable {
            let keyboard = page.app.keyboards.firstMatch

            if keyboard.exists {
                let doneButton = keyboard.buttons["Done"]

                if doneButton.exists && doneButton.isHittable {
                    doneButton.tap()
                }
            }
        }

        waitForHittable(button)
        button.tap()
    }



    func assertLoginErrorContains(_ expectedText: String) {
        let errorMessage = page.loginErrorMessage

        XCTAssertTrue(
            errorMessage.waitForExistence(timeout: 10),
            "Authentication error was not displayed"
        )

        XCTAssertTrue(
            errorMessage.label.contains(expectedText),
            "Expected error to contain '\(expectedText)', but got '\(errorMessage.label)'"
        )
    }



    func openRegistration() {
        let button = page.onboardingRegisterButton

        XCTAssertTrue(
            button.waitForExistence(timeout: 10),
            "Onboarding Register button was not found"
        )

        button.tap()
    }

    func enterRegistrationEmail(_ email: String) {
        let field = page.registrationEmailField

        XCTAssertTrue(
            field.waitForExistence(timeout: 10),
            "Registration email field was not found"
        )

        field.tap()
        field.typeText(email)
    }

    
func dismissStrongPasswordPromptIfPresent() {
    let app = page.app

    let closeButton = app.buttons["Close"].firstMatch

    if closeButton.exists && closeButton.isHittable {
        closeButton.tap()
    }

    let useOwnPasswordButton = app.buttons[
        "Use My Own Password"
    ].firstMatch

    if useOwnPasswordButton.exists &&
       useOwnPasswordButton.isHittable {
        useOwnPasswordButton.tap()
    }
}


    func submitRegistration() {
        let button = page.registrationSubmitButton

        XCTAssertTrue(
            button.waitForExistence(timeout: 10),
            "Registration submit button was not found"
        )

        button.tap()
    }

    func assertHomeDisplayed() {
        let sendMoneyButton = page.sendMoneyButton

        XCTAssertTrue(
            sendMoneyButton.waitForExistence(timeout: 15),
            "Home screen was not displayed"
        )
    }

    func logout() {
        let logoutButton = page.logoutButton

        XCTAssertTrue(
            logoutButton.waitForExistence(timeout: 10),
            "Logout button was not found"
        )

        logoutButton.tap()

        let alert = page.logoutAlert

        XCTAssertTrue(
            alert.waitForExistence(timeout: 10),
            "Logout confirmation alert was not displayed"
        )

        page.confirmLogoutButton.tap()

        XCTAssertTrue(
            page.loginEmailField.waitForExistence(timeout: 10),
            "Login screen was not displayed after logout"
        )
    }
    func enterRegistrationPassword(_ password: String) {
    let visibilityButton = page.registrationPasswordVisibilityButton
    XCTAssertTrue(visibilityButton.waitForExistence(timeout: 10))
    visibilityButton.tap()

    let field = page.app.textFields["registration.password"]
    XCTAssertTrue(field.waitForExistence(timeout: 10))
    field.tap()
    field.typeText(password)
}

func enterRepeatPassword(_ password: String) {
    let visibilityButton = page.registrationRepeatPasswordVisibilityButton
    XCTAssertTrue(visibilityButton.waitForExistence(timeout: 10))
    visibilityButton.tap()

    let field = page.app.textFields["registration.repeatPassword"]
    XCTAssertTrue(field.waitForExistence(timeout: 10))
    field.tap()
    field.typeText(password)
}
}
