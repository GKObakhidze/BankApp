
import XCTest

final class EasyBankPage {
    private let app: XCUIApplication
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

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
    var registrationErrorLabel: XCUIElement { app.staticTexts["registration.error"] }

    var sendMoneyButton: XCUIElement { app.buttons["home.sendMoney"] }
    var logoutButton: XCUIElement { app.buttons["home.logout"] }


    var logoutAlert: XCUIElement { app.alerts["Logging Out"] }
    var logoutConfirmButton: XCUIElement { logoutAlert.buttons["Yes"] }


    var keyboard: XCUIElement { app.keyboards.firstMatch }

    var strongPasswordDismissButtons: [XCUIElement] {
        ["Close", "Choose My Own Password"].flatMap { label in
            [app.buttons[label], springboard.buttons[label]]
        }
    }

    
    var savePasswordNotNowButtons: [XCUIElement] {
        [app.buttons["Not Now"], springboard.buttons["Not Now"]]
    }
}
