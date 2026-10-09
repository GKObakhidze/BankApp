import XCTest

final class BankingFlowTests: BaseClass {
    func testInvalidEmailFormat() {
        EasyBankSteps(app: app)
            .openLogin()
            .enterEmail("invalid-email")
            .enterPassword("BankTest!2026")
            .submitLogin()
            .verifyLoginError("badly formatted")
            .verifyLoginScreen()
    }

    func testInvalidLoginCredentials() {
        let email = "unregistered-\(UUID().uuidString.lowercased())@example.com"

        EasyBankSteps(app: app)
            .openLogin()
            .enterEmail(email)
            .enterPassword("WrongPassword!2026")
            .submitLogin()
            .verifyLoginError("malformed or has expired")
            .verifyLoginScreen()
    }

    func testRegisterLogoutLogin() {
        let email = "banktest-\(UUID().uuidString.lowercased())@example.com"
        let password = "BankTest!2026"

        EasyBankSteps(app: app)
            .openRegistration()
            .enterRegistrationEmail(email)
            .enterRegistrationPassword(password)
            .enterRepeatPassword(password)
            .submitRegistration()
            .verifyHomeScreen()
            .openLogoutConfirmation()
            .confirmLogout()
            .verifyLoginScreen()
            .enterEmail(email)
            .enterPassword(password)
            .submitLogin()
            .verifyHomeScreen()
    }
}
