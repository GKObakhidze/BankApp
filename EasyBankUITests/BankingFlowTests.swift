import XCTest

final class BankingFlowTests: BaseClass {
    private var steps: EasyBankSteps!

    override func setUp() {
        super.setUp()
        steps = EasyBankSteps(app)
    }

    func testInvalidEmailFormat() {
        steps.openLogin()
        steps.logIn(email: TestData.invalidEmail, password: TestData.password)
        steps.assertLoginError(contains: ErrorText.badlyFormatted)
    }

    func testInvalidCredentials() {
        steps.openLogin()
        steps.logIn(email: TestData.uniqueEmail(prefix: "missing"), password: TestData.password)
        steps.assertLoginError(contains: ErrorText.invalidCredentials)
    }

    func testRegisterLogoutLogin() {
        let email = TestData.uniqueEmail(prefix: "qa")

        steps.register(email: email, password: TestData.password)
        steps.assertMainScreen()
        steps.logOut()
        steps.logIn(email: email, password: TestData.password)
        steps.assertMainScreen()
    }
}