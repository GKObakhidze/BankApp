import XCTest

final class EasyBankPage {
    private let app: XCUIApplication
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

    init(app: XCUIApplication) {
        self.app = app
    }

    // Onboarding
    var onboardingLoginButton: XCUIElement {
        app.buttons["onboarding.login"]
    }

    var onboardingRegisterButton: XCUIElement {
        app.buttons["onboarding.register"]
    }

    // Login
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

    // Registration
    var registrationEmailField: XCUIElement {
        app.textFields["registration.email"]
    }

    var registrationPasswordSecureField: XCUIElement {
        app.secureTextFields["registration.password"]
    }

    var registrationPasswordVisibleField: XCUIElement {
        app.textFields["registration.password"]
    }

    var registrationRepeatPasswordSecureField: XCUIElement {
        app.secureTextFields["registration.repeatPassword"]
    }

    var registrationRepeatPasswordVisibleField: XCUIElement {
        app.textFields["registration.repeatPassword"]
    }

    var registrationPasswordVisibilityButton: XCUIElement {
        registrationPasswordSecureField.buttons.firstMatch
    }

    var registrationRepeatPasswordVisibilityButton: XCUIElement {
        registrationRepeatPasswordSecureField.buttons.firstMatch
    }

    var registrationSubmitButton: XCUIElement {
        app.buttons["registration.submit"]
    }

    // Strong password prompt
    var strongPasswordCloseButtonInApp: XCUIElement {
        app.buttons["Close"]
    }

    var strongPasswordCloseButtonInSpringboard: XCUIElement {
        springboard.buttons["Close"]
    }

    // Home
    var sendMoneyButton: XCUIElement {
        app.buttons["home.sendMoney"]
    }

    var logoutButton: XCUIElement {
        app.buttons["home.logout"]
    }

    // Logout
    var logoutAlert: XCUIElement {
        app.alerts["Logging Out"]
    }

    var logoutYesButton: XCUIElement {
        logoutAlert.buttons["Yes"]
    }
}