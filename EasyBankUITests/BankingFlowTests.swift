import XCTest

final class BankingFlowTests: BaseClass {

    private let steps = EasyBankSteps()

    func testInvalidEmailFormat() {
        steps.tapOnboardingLogin()
        login(email: Constants.invalidEmail, password: Constants.password)
        steps.validateLoginErrorContains(Constants.badlyFormattedError)
    }

    func testInvalidCredentials() {
        steps.tapOnboardingLogin()
        login(email: Constants.uniqueEmail, password: Constants.password)
        steps.validateLoginErrorContains(Constants.invalidCredentialsError)
    }

    func testRegisterLogoutAndLogin() {
        let email = Constants.uniqueEmail

        steps.tapOnboardingRegister()
            .enterRegistrationEmail(email)
            .enterRegistrationPassword(Constants.password)
            .enterRegistrationRepeatPassword(Constants.password)
            .tapRegistrationSubmit()
            .validateHomeDisplayed()
            .tapLogout()
            .confirmLogout()
        login(email: email, password: Constants.password)
        steps.validateHomeDisplayed()
    }

    private func login(email: String, password: String) {
        steps.enterLoginEmail(email)
            .enterLoginPassword(password)
            .tapLoginSubmit()
    }
}