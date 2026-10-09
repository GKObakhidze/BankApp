import XCTest

final class EasyBankPage {
    private let app: XCUIApplication
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

    init(app: XCUIApplication) {
        self.app = app
    }

    var onboardingLoginButton: XCUIElement {
        app.buttons["onboarding.login"]
    }

    var onboardingRegisterButton: XCUIElement {
        app.buttons["onboarding.register"]
    }

    var loginEmailField: XCUIElement {
        app.textFields["login.email"]
    }

    var loginPasswordField: XCUIElement {
        app.secureTextFields["login.password"]
    }

    var loginSubmitButton: XCUIElement {
        app.buttons["login.submit"]
    }

    var loginError: XCUIElement {
        app.staticTexts["login.error"]
    }

    var registrationEmailField: XCUIElement {
        app.textFields["registration.email"]
    }

    var registrationPasswordField: XCUIElement {
        app.descendants(matching: .any)
            .matching(identifier: "registration.password")
            .firstMatch
    }

    var registrationRepeatPasswordField: XCUIElement {
        app.descendants(matching: .any)
            .matching(identifier: "registration.repeatPassword")
            .firstMatch
    }

    var registrationPasswordVisibilityButton: XCUIElement {
        registrationPasswordField.buttons.firstMatch
    }

    var registrationRepeatPasswordVisibilityButton: XCUIElement {
        registrationRepeatPasswordField.buttons.firstMatch
    }

    var registrationSubmitButton: XCUIElement {
        app.buttons["registration.submit"]
    }

    var strongPasswordCloseButtonInApp: XCUIElement {
        app.buttons["Close"]
    }

    var strongPasswordCloseButtonInSpringboard: XCUIElement {
        springboard.buttons["Close"]
    }

    var sendMoneyButton: XCUIElement {
        app.buttons["home.sendMoney"]
    }

    var logoutButton: XCUIElement {
        app.buttons["home.logout"]
    }

    var logoutAlert: XCUIElement {
        app.alerts["Logging Out"]
    }

    var logoutYesButton: XCUIElement {
        logoutAlert.buttons["Yes"]
    }
}