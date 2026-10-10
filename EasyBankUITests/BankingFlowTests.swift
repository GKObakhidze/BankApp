import XCTest

final class BankingFlowTests: BaseClass {
    private var steps: EasyBankSteps!

    override func setUp() {
        super.setUp()
        steps = EasyBankSteps(app: app)
    }

    func testLoginWithInvalidEmailFormat() {
        steps.onboarding
            .openLogin()
            .logIn(email: Constants.TestData.invalidEmail, password: Constants.TestData.validPassword)
            .assertErrorContains(Constants.ErrorText.badlyFormattedEmail)
    }

    func testLoginWithUnregisteredCredentials() {
        steps.onboarding
            .openLogin()
            .logIn(email: Constants.TestData.uniqueEmail(), password: Constants.TestData.validPassword)
            .assertErrorContains(Constants.ErrorText.malformedOrExpired)
    }

    func testRegisterLogOutAndLogInAgain() {
        let email = Constants.TestData.uniqueEmail()
        let password = Constants.TestData.validPassword

        steps.onboarding
            .openRegistration()
            .register(email: email, password: password)
            .expectHome()
            .logOut()
            .assertDisplayed()
            .logIn(email: email, password: password)
            .expectHome()
    }
}
