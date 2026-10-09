import XCTest

class EasyBankPage {
    let app: XCUIApplication
    init(_ app: XCUIApplication) { self.app = app }

    var onboardingLogin: XCUIElement { app.buttons["onboarding.login"] }
    var onboardingRegister: XCUIElement { app.buttons["onboarding.register"] }

    var loginEmail: XCUIElement { app.textFields["login.email"] }
    var loginPassword: XCUIElement { app.secureTextFields["login.password"] }
    var loginSubmit: XCUIElement { app.buttons["login.submit"] }
    var loginError: XCUIElement { app.staticTexts["login.error"] }

    var registerEmail: XCUIElement { app.textFields["registration.email"] }
    var registerPassword: XCUIElement { app.descendants(matching: .any).matching(identifier: "registration.password").firstMatch }
    var registerRepeatPassword: XCUIElement { app.descendants(matching: .any).matching(identifier: "registration.repeatPassword").firstMatch }
    var registerSubmit: XCUIElement { app.buttons["registration.submit"] }

    var sendMoney: XCUIElement { app.buttons["home.sendMoney"] }
    var logout: XCUIElement { app.buttons["home.logout"] }
    var logoutYes: XCUIElement { app.alerts["Logging Out"].buttons["Yes"] }

    var strongPasswordClose: XCUIElement { app.buttons["Close"] }
    var keyboardReturn: XCUIElement { app.buttons["Return"] }
}