import XCTest

final class BankingFlowTests: BaseClass {

    private lazy var steps = EasyBankSteps(app: app)

    func testLogInWithInvalidEmailFormat_showsBadlyFormattedError() {
        steps
            .tapOnboardingLogIn()
            .verifyLoginFormIsDisplayed()
            .enterLoginEmail(Constants.invalidEmail)
            .enterLoginPassword(Constants.testPassword)
            .tapLogInSubmit()
            .verifyLoginErrorContains(Constants.badlyFormattedError)
    }

    func testLogInWithUnregisteredAccount_showsInvalidCredentialsError() {
        steps
            .tapOnboardingLogIn()
            .verifyLoginFormIsDisplayed()
            .enterLoginEmail(Constants.unregisteredEmail)
            .enterLoginPassword(Constants.testPassword)
            .tapLogInSubmit()
            .verifyLoginErrorContains(Constants.invalidCredentialsError)
    }

    func testRegisterLogOutAndLogIn_showsHomeScreen() {
        let email = "\(Constants.emailPrefix).\(Int(Date().timeIntervalSince1970 * 1000))@\(Constants.emailDomain)"

        steps
            .tapOnboardingRegister()
            .verifyRegistrationFormIsDisplayed()
            .enterRegistrationEmail(email)
            .enterRegistrationPassword(Constants.testPassword)
            .enterRepeatPassword(Constants.testPassword)
            .tapRegisterSubmit()
            .verifyHomeScreenIsDisplayed()
            .tapLogOut()
            .confirmLogOut()
            .logIn(email: email, password: Constants.testPassword)
            .verifyHomeScreenIsDisplayed()
    }
}
