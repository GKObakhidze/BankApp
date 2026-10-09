import XCTest

class EasyBankPage: BaseClass {

    // Onboarding
    var onboardingLoginButton: XCUIElement { app.buttons["onboarding.login"] }
    var onboardingRegisterButton: XCUIElement { app.buttons["onboarding.register"] }

    // Login
    var loginEmailField: XCUIElement { app.textFields["login.email"] }
    var loginPasswordField: XCUIElement { app.secureTextFields["login.password"] }
    var loginSubmitButton: XCUIElement { app.buttons["login.submit"] }
    var loginErrorText: XCUIElement { app.staticTexts["login.error"] }

    // Registration
    var registrationEmailField: XCUIElement { app.textFields["registration.email"] }
    var registrationPasswordToggle: XCUIElement { app.secureTextFields["registration.password"].buttons["hide"] }
    var registrationRepeatPasswordToggle: XCUIElement { app.secureTextFields["registration.repeatPassword"].buttons["hide"] }
    var registrationPasswordField: XCUIElement { app.textFields["registration.password"] }
    var registrationRepeatPasswordField: XCUIElement { app.textFields["registration.repeatPassword"] }
    var registrationSubmitButton: XCUIElement { app.buttons["registration.submit"] }

    // Home
    var homeTabButton: XCUIElement { app.tabBars.buttons["Home"] }
    var sendMoneyButton: XCUIElement { app.buttons["home.sendMoney"] }
    var logoutButton: XCUIElement { app.buttons["home.logout"] }

    // Logout alert
    var logoutAlert: XCUIElement { app.alerts["Logging Out"] }
    var logoutConfirmButton: XCUIElement { logoutAlert.buttons["Yes"] }
}