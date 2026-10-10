
import XCTest

final class BankingFlowTests: BaseClass {



    func testInvalidEmailFormat() {
        let steps = EasyBankSteps(app: app)

        steps.openLogin()
        steps.enterEmail("invalid-email")
        steps.enterPassword("Test12345!")
        steps.submitLogin()

        steps.assertLoginErrorContains("badly formatted")
    }



    func testInvalidLoginCredentials() {
        let steps = EasyBankSteps(app: app)

        steps.openLogin()
        steps.enterEmail(
            "unregistered-\(UUID().uuidString)@example.com"
        )
        steps.enterPassword("Test12345!")
        steps.submitLogin()

        steps.assertLoginErrorContains("malformed or has expired")
    }



    func testRegisterLogoutLogin() {
        let steps = EasyBankSteps(app: app)

        let email = "test-\(UUID().uuidString)@example.com"
        let password = "Test12345!"

        steps.openRegistration()
        steps.enterRegistrationEmail(email)
        steps.enterRegistrationPassword(password)
        steps.enterRepeatPassword(password)
        steps.submitRegistration()

        steps.assertHomeDisplayed()

        steps.logout()

        steps.enterEmail(email)
        steps.enterPassword(password)
        steps.submitLogin()

        steps.assertHomeDisplayed()
    }
}
