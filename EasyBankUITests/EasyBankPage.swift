
import XCTest

final class EasyBankPage {

    let app: XCUIApplication

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

    var loginErrorMessage: XCUIElement {
        app.staticTexts["login.error"]
    }


    var registrationEmailField: XCUIElement {
        app.textFields["registration.email"]
    }

    var registrationPasswordField: XCUIElement {
        app.secureTextFields["registration.password"]
    }

    var registrationRepeatPasswordField: XCUIElement {
        app.secureTextFields["registration.repeatPassword"]
    }

    var registrationSubmitButton: XCUIElement {
        app.buttons["registration.submit"]
    }



    var homeTab: XCUIElement {
        app.tabBars.buttons["Home"]
    }

    var sendMoneyButton: XCUIElement {
        app.buttons["home.sendMoney"]
    }

    var logoutButton: XCUIElement {
        app.buttons["home.logout"]
    }

    // MARK: - Logout Confirmation

    var logoutAlert: XCUIElement {
        app.alerts["Logging Out"]
    }

    var confirmLogoutButton: XCUIElement {
        logoutAlert.buttons["Yes"]
    }

    var cancelLogoutButton: XCUIElement {
        logoutAlert.buttons["No"]
    }
    var registrationPasswordVisibilityButton: XCUIElement {
    registrationPasswordField.buttons["hide"]
}

var registrationRepeatPasswordVisibilityButton: XCUIElement {
    registrationRepeatPasswordField.buttons["hide"]
}
}
