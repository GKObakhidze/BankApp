import XCTest

final class BankingFlowTests: EasyBankSteps {
    private let testPassword = "Qa!Test#2026"

    func testLoginWithInvalidEmailFormatShowsError() {
        openLoginForm()
        submitLogin(email: "invalid-email", password: testPassword)
        verifyLoginError(contains: "badly formatted")
    }

    func testLoginWithUnregisteredCredentialsShowsError() {
        openLoginForm()
        submitLogin(email: uniqueEmail(), password: testPassword)
        verifyLoginError(contains: "malformed or has expired")
    }

    func testRegisterLogoutAndLogin() {
        let email = uniqueEmail()

        disablePasswordAutoFill()
        openRegistrationForm()
        submitRegistration(email: email, password: testPassword)
        verifyHomeScreenDisplayed()

        logOut()
        verifyLoginFormDisplayed()

        submitLogin(email: email, password: testPassword)
        verifyHomeScreenDisplayed()
    }
}
