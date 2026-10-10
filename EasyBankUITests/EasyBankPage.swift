import XCTest

class EasyBankPage {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var onboardingLoginButton: XCUIElement {
        app.buttons["Log In"].firstMatch
    }

    var onboardingRegisterButton: XCUIElement {
        app.buttons["Register"].firstMatch
    }

    var loginEmailField: XCUIElement {
        let field = app.textFields["loginEmailField"]
        return field.exists ? field : app.textFields["Email"].firstMatch
    }

    var loginPasswordField: XCUIElement {
        let field = app.secureTextFields["loginPasswordField"]
        return field.exists ? field : app.secureTextFields["Password"].firstMatch
    }

    var loginSubmitButton: XCUIElement {
        let button = app.buttons["loginSubmitButton"]
        return button.exists ? button : app.buttons["Log In"].firstMatch
    }

    var registerEmailField: XCUIElement {
        let field = app.textFields["registerEmailField"]
        return field.exists ? field : app.textFields["Email"].firstMatch
    }

    var registerPasswordField: XCUIElement {
        let field = app.secureTextFields["registerPasswordField"]
        return field.exists ? field : app.secureTextFields["Password"].firstMatch
    }

    var registerRepeatPasswordField: XCUIElement {
        let field = app.secureTextFields["registerRepeatPasswordField"]
        return field.exists ? field : app.secureTextFields["Repeat Password"].firstMatch
    }

    var registerSubmitButton: XCUIElement {
        let button = app.buttons["registerSubmitButton"]
        return button.exists ? button : app.buttons["Register"].firstMatch
    }

    var strongPasswordCloseButton: XCUIElement {
        app.buttons["Close"].firstMatch
    }

    var homeTab: XCUIElement {
        let tab = app.tabBars.buttons["Home"].firstMatch
        return tab.exists ? tab : app.buttons["Home"].firstMatch
    }

    var sendMoneyButton: XCUIElement {
        app.buttons["Send Money"].firstMatch
    }

    var logoutButton: XCUIElement {
        let button = app.buttons["logoutButton"]
        return button.exists ? button : app.navigationBars.buttons.element(boundBy: 0)
    }

    var logoutConfirmAlertButton: XCUIElement {
        app.alerts.buttons["Yes"].firstMatch
    }

    var errorLabels: XCUIElementQuery {
        app.staticTexts
    }
}
