import XCTest

final class BankingFlowTests: BaseClass {
    private var steps: EasyBankSteps!

    override func setUp() {
        super.setUp()
        steps = EasyBankSteps(app: app)
    }

    func testLoginWithInvalidEmailFormatShowsError() {
        steps
            .assertOnboardingDisplayed()
            .openLogin()
            .logIn(email: TestData.invalidEmail, password: TestData.password)
            .assertLoginErrorContains(TestData.invalidEmailErrorFragment)
    }

    func testLoginWithUnregisteredCredentialsShowsError() {
        let email = TestData.uniqueEmail()

        steps
            .assertOnboardingDisplayed()
            .openLogin()
            .logIn(email: email, password: TestData.password)
            .assertLoginErrorContains(TestData.invalidCredentialsErrorFragment)
    }

    func testRegisterLogOutAndLogIn() {
        let email = TestData.uniqueEmail()
        let password = TestData.strongPassword

        steps
            .assertOnboardingDisplayed()
            .openRegistration()
            .register(email: email, password: password)
            .assertHomeDisplayed()
            .logOut()
            .logIn(email: email, password: password)
            .assertHomeDisplayed()
    }
}
