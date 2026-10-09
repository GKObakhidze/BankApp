import XCTest

class EasyBankPage: BaseClass {
    var onboardingLoginButton: XCUIElement { app.buttons["onboarding.login"] }
    var onboardingRegisterButton: XCUIElement { app.buttons["onboarding.register"] }

    var loginEmailField: XCUIElement { app.textFields["login.email"] }
    var loginPasswordField: XCUIElement { app.secureTextFields["login.password"] }
    var loginSubmitButton: XCUIElement { app.buttons["login.submit"] }
    var loginErrorText: XCUIElement { app.staticTexts["login.error"] }

    var registrationEmailField: XCUIElement { app.textFields["registration.email"] }
    var registrationPasswordField: XCUIElement { app.secureTextFields["registration.password"] }
    var registrationRepeatPasswordField: XCUIElement { app.secureTextFields["registration.repeatPassword"] }
    var registrationSubmitButton: XCUIElement { app.buttons["registration.submit"] }
    var registrationErrorText: XCUIElement { app.staticTexts["registration.error"] }

    var springboard: XCUIApplication { XCUIApplication(bundleIdentifier: "com.apple.springboard") }
    var strongPasswordCloseButtons: [XCUIElement] { [app.buttons["Close"], springboard.buttons["Close"]] }

    var settingsApp: XCUIApplication { XCUIApplication(bundleIdentifier: "com.apple.Preferences") }
    var settingsGeneralRow: XCUIElement { settingsRow("General") }
    var settingsAutoFillRow: XCUIElement { settingsRow("AutoFill & Passwords") }
    var settingsAutoFillSwitch: XCUIElement { settingsApp.switches["AutoFill Passwords and Passkeys"] }

    var homeTabButton: XCUIElement { app.tabBars.buttons["Home"] }
    var sendMoneyButton: XCUIElement { app.buttons["home.sendMoney"] }
    var logoutButton: XCUIElement { app.buttons["home.logout"] }

    var logoutAlert: XCUIElement { app.alerts["Logging Out"] }
    var logoutConfirmButton: XCUIElement { logoutAlert.buttons["Yes"] }

    private func settingsRow(_ label: String) -> XCUIElement {
        settingsApp.descendants(matching: .any).matching(NSPredicate(format: "label == %@", label)).firstMatch
    }
}
