import XCTest

final class BankingFlowTests: BaseClass {
    private let steps = EasyBankSteps()

    /// Verify that logging in with a badly formatted email shows the email format error.
    func testLoginWithInvalidEmailFormatShowsFormatError() {
        steps
            .openLoginForm()
            .enterLoginEmail(EasyBankConstants.Credentials.invalidFormatEmail)
            .enterLoginPassword(EasyBankConstants.Credentials.password)
            .submitLogin()
            .verifyLoginError(contains: EasyBankConstants.ErrorFragment.badlyFormattedEmail)
    }

    /// Verify that logging in with an unregistered account shows the authentication error.
    func testLoginWithUnregisteredAccountShowsAuthenticationError() {
        let email = EasyBankTestData.unregisteredEmail()

        steps
            .openLoginForm()
            .enterLoginEmail(email)
            .enterLoginPassword(EasyBankConstants.Credentials.password)
            .submitLogin()
            .verifyLoginError(contains: EasyBankConstants.ErrorFragment.invalidCredentials)
    }

    /// Verify that a newly registered user reaches the main screen, can log out and log back in.
    func testRegisteredUserCanLogOutAndLogInAgain() {
        let email = EasyBankTestData.newAccountEmail()
        let password = EasyBankConstants.Credentials.password

        steps
            .openRegistrationForm()
            .register(email: email, password: password)
            .verifyMainScreenDisplayed()
            .logOut()
            .verifyLoginFormDisplayed()
            .logIn(email: email, password: password)
            .verifyMainScreenDisplayed()
    }
}
