import XCTest

final class BankingFlowTests: EasyBankSteps {

    func testLoginWithInvalidEmailFormat() {
        openLoginFromOnboarding()
        login(email: Constants.invalidEmail, password: Constants.password)
        assertLoginErrorContains([Constants.badlyFormattedError])
    }

    func testLoginWithUnregisteredEmail() {
        openLoginFromOnboarding()
        login(email: Constants.unregisteredEmail, password: Constants.password)
        assertLoginErrorContains([Constants.malformedError, Constants.expiredError])
    }

    func testRegisterLogoutAndLogin() {
        let uniqueId = String(UUID().uuidString.lowercased().prefix(8))
        let email = Constants.emailPrefix + uniqueId + Constants.emailDomain

        openRegistrationFromOnboarding()
        register(email: email, password: Constants.password)
        assertMainScreenDisplayed()

        logout()
        assertLoginFormDisplayed()

        login(email: email, password: Constants.password)
        assertMainScreenDisplayed()
    }
}