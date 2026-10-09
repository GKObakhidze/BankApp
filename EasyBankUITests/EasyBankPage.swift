import XCTest

final class EasyBankPage {
    private let app: XCUIApplication
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

    init(app: XCUIApplication) {
        self.app = app
    }

    var onboardingLogin: XCUIElement { app.buttons["onboarding.login"] }
    var onboardingRegister: XCUIElement { app.buttons["onboarding.register"] }

    var loginEmail: XCUIElement { app.textFields["login.email"] }
    var loginPassword: XCUIElement { app.secureTextFields["login.password"] }
    var loginSubmit: XCUIElement { app.buttons["login.submit"] }
    var loginError: XCUIElement { app.staticTexts["login.error"] }

    var registrationEmail: XCUIElement { app.textFields["registration.email"] }
    var registrationPassword: XCUIElement { app.secureTextFields["registration.password"] }
    var registrationRepeatPassword: XCUIElement {
        app.secureTextFields["registration.repeatPassword"]
    }
    var registrationSubmit: XCUIElement { app.buttons["registration.submit"] }

    var homeTab: XCUIElement { app.tabBars.buttons["Home"] }
    var sendMoney: XCUIElement { app.buttons["home.sendMoney"] }
    var logout: XCUIElement { app.navigationBars.buttons["home.logout"] }
    var logoutConfirmation: XCUIElement { app.alerts["Logging Out"] }
    var confirmLogout: XCUIElement { logoutConfirmation.buttons["Yes"] }

    var strongPasswordClose: XCUIElement { app.buttons["Close"] }
    var systemStrongPasswordClose: XCUIElement { springboard.buttons["Close"] }
}
