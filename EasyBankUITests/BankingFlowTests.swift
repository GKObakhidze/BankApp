import XCTest

final class BankingFlowTests: BaseClass {
    private var steps: EasyBankSteps!

    override func setUpWithError() throws {
        try super.setUpWithError()
        steps = EasyBankSteps(app: app)
    }

    override func tearDownWithError() throws {
        steps = nil
        try super.tearDownWithError()
    }

    func testInvalidEmailFormat() {
        steps
            .tapOnboardingLogin()
            .enterLoginEmail("invalid-email")
            .enterLoginPassword("TestPassword123!")
            .tapLoginSubmit()
            .assertErrorMessageContains("badly formatted")
    }

    func testInvalidLoginCredentials() {
        let unregisteredEmail = "unregistered_\(UUID().uuidString.prefix(6))@test.com"

        steps
            .tapOnboardingLogin()
            .enterLoginEmail(unregisteredEmail)
            .enterLoginPassword("WrongPassword123!")
            .tapLoginSubmit()
            .assertErrorMessageContains("malformed or has expired")
    }

    func testRegisterLogoutAndLogin() {
        let uniqueEmail = "testuser_\(UUID().uuidString.prefix(8))@easybank.test"
        let testPassword = "ValidSecurePass123"

        steps
            .tapOnboardingRegister()
            .enterRegisterEmail(uniqueEmail)
            .enterRegisterPassword(testPassword)
            .enterRegisterRepeatPassword(testPassword)
            .tapRegisterSubmit()
            .assertMainScreenDisplayed()
            .tapLogout()
            .confirmLogout()
            .tapOnboardingLogin()
            .enterLoginEmail(uniqueEmail)
            .enterLoginPassword(testPassword)
            .tapLoginSubmit()
            .assertMainScreenDisplayed()
    }
}
