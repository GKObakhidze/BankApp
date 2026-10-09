import XCTest

final class BankingFlowTests: BaseClass {
    private lazy var easyBankSteps = EasyBankSteps(app: app)

    func testInvalidEmailFormat() {
        easyBankSteps
        .openLogin()
        .validateLoginScreen()
        .enterEmail(Constants.invalidEmail)
        .enterPassword(Constants.invalidPassword)
        .submitLogin()
        .validateLoginErrorContains(Constants.badlyFormattedError)
        .validateLoginScreen()
    }

    func testInvalidLoginCredentials() {
        let email = Constants.uniqueUnregisteredEmail()

        easyBankSteps
        .openLogin()
        .validateLoginScreen()
        .enterEmail(email)
        .enterPassword(Constants.invalidPassword)
        .submitLogin()
        .validateLoginErrorContains(Constants.invalidCredentialsError)
        .validateLoginScreen()

    }

    func testRegisterLogoutAndLogin() {
        let email = Constants.uniqueRegistrationEmail()
        let password = Constants.testPassword

        easyBankSteps
        .openRegistration()
        .enterRegistrationEmail(email)
        .enterRegistrationPassword(password)
        .enterRepeatPassword(password)
        .submitRegistration()
        .validateHomeScreen()
        .logout()
        .validateLoginScreen()
        .enterEmail(email)
        .enterPassword(password)
        .submitLogin()
        .validateHomeScreen()
    }
}
