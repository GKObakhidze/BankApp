import XCTest

final class BankingFlowTests: BaseClass {

    func testInvalidEmailFormat() {
        let steps = EasyBankSteps(app: app)

        steps
            .openLogin()
            .enterLoginEmail("invalid-email")
            .enterLoginPassword("TestPassword123!")
            .submitLogin()
            .verifyLoginErrorContains("badly formatted")
    }

    func testInvalidLoginCredentials() {
        let steps = EasyBankSteps(app: app)
        let email = "unregistered.\(UUID().uuidString)@example.com"

        steps
            .openLogin()
            .enterLoginEmail(email)
            .enterLoginPassword("TestPassword123!")
            .submitLogin()
            .verifyLoginErrorContains("malformed or has expired")
    }

    func testRegisterLogoutAndLogin() {
        let steps = EasyBankSteps(app: app)
        let email = "uitest.\(UUID().uuidString)@example.com"
        let password = "TestPassword123!"

        steps
            .openRegistration()
            .enterRegistrationEmail(email)
            .enterRegistrationPassword(password)
            .enterRegistrationRepeatPassword(password)
            .submitRegistration()
            .verifyHomeDisplayed()
            .logout()
            .enterLoginEmail(email)
            .enterLoginPassword(password)
            .submitLogin()
            .verifyHomeDisplayed()
    }
}