import XCTest

final class EasyBankPage {

    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var onboardingLoginButton: XCUIElement { app.buttons["onboarding.login"] }
    var onboardingRegisterButton: XCUIElement { app.buttons["onboarding.register"] }

    var loginEmailField: XCUIElement { app.textFields["login.email"] }
    var loginPasswordField: XCUIElement { app.secureTextFields["login.password"] }
    var loginSubmitButton: XCUIElement { app.buttons["login.submit"] }
    var loginErrorLabel: XCUIElement { app.staticTexts["login.error"] }

    var registrationEmailField: XCUIElement { app.textFields["registration.email"] }
    var registrationPasswordField: XCUIElement { app.secureTextFields["registration.password"] }
    var registrationRepeatPasswordField: XCUIElement { app.secureTextFields["registration.repeatPassword"] }
    var registrationSubmitButton: XCUIElement { app.buttons["registration.submit"] }

    var homeSendMoneyButton: XCUIElement { app.buttons["home.sendMoney"] }
    var homeLogoutButton: XCUIElement { app.buttons["home.logout"] }

    var logoutAlert: XCUIElement { app.alerts[logoutAlertTitle] }
    var logoutConfirmYesButton: XCUIElement { app.alerts[logoutAlertTitle].buttons[logoutYesButtonTitle] }
    var strongPasswordCloseButton: XCUIElement { app.buttons[strongPasswordCloseButtonTitle] }
    var keyboardReturnKey: XCUIElement { app.keyboards.buttons["Return"] }
}