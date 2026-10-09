import XCTest

final class EasyBankPage {

    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    // onboarding
    var onboardingLogin: XCUIElement {
        app.buttons["onboarding.login"]
    }

    var onboardingRegister: XCUIElement {
        app.buttons["onboarding.register"]
    }

    // login
    var loginEmail: XCUIElement {
        app.textFields["login.email"]
    }

    var loginPassword: XCUIElement {
        app.secureTextFields["login.password"]
    }

    var loginPasswordVisibility: XCUIElement {
        loginPassword.buttons["hide"]
    }

    var visibleLoginPassword: XCUIElement {
        app.textFields["login.password"]
    }

    var loginSubmit: XCUIElement {
        app.buttons["login.submit"]
    }

    var loginError: XCUIElement {
        app.staticTexts["login.error"]
    }


    // registation

    var registrationEmail: XCUIElement {
        app.textFields["registration.email"]
    }

    var registrationPassword: XCUIElement {
        app.secureTextFields["registration.password"]
    }

    var registrationPasswordVisibility: XCUIElement {
        registrationPassword.buttons["hide"]
    }

    var visibleRegistrationPassword: XCUIElement {
        app.textFields["registration.password"]}

    var repeatPassword: XCUIElement {
        app.secureTextFields["registration.repeatPassword"]
    }

    var repeatPasswordVisibility: XCUIElement {
        repeatPassword.buttons["hide"]
    }

    var visibleRepeatPassword: XCUIElement {
        app.textFields["registration.repeatPassword"]
    }

    var registrationSubmit: XCUIElement {
        app.buttons["registration.submit"]
    }

    // home
    var homeTab: XCUIElement {
        app.tabBars.buttons["Home"]
    }

    var sendMoney: XCUIElement {
        app.buttons["home.sendMoney"]
    }

    var logoutButton: XCUIElement {
        app.buttons["home.logout"]
    }

    // logout confirmation
    var logoutAlert: XCUIElement {
        app.alerts["Logging Out"]
    }

    var confirmLogout: XCUIElement {
        logoutAlert.buttons["Yes"]
    }

    // system password prompt
    var strongPasswordClose: XCUIElement {
        app.buttons["Close"].firstMatch
    }

}
