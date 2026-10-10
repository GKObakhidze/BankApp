import XCTest

final class BankingFlowTests: BaseClass {
    private var steps: EasyBankSteps { EasyBankSteps(app: app) }

    func testLoginWithInvalidEmailFormat() {
        steps.logIn(email: "invalid-email", password: "Test1234")
        steps.assertLoginErrorContainsAny(of: ["badly formatted"])
    }

    func testLoginWithUnregisteredCredentials() {
        steps.logIn(email: EasyBankSteps.uniqueEmail(), password: "Test1234")
        steps.assertLoginErrorContainsAny(of: ["malformed", "has expired"])
    }

    func testRegisterLogoutAndLogin() {
        let email = EasyBankSteps.uniqueEmail()
        let password = "Test1234"

        steps.register(email: email, password: password)
        steps.assertMainScreenDisplayed()

        steps.logOut()
        steps.logInFromLoginForm(email: email, password: password)
        steps.assertMainScreenDisplayed()
    }
}