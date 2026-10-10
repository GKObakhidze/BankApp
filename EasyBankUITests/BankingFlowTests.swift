import XCTest

/// Tests: prepare scenario data and orchestrate the scenario through Steps.
final class BankingFlowTests: BaseClass {
    private var steps: EasyBankSteps!

    override func setUp() {
        super.setUp()
        steps = EasyBankSteps(app: app)
    }

    // MARK: - Test case 1

    func testLoginWithInvalidEmailFormatShowsError() {
        let invalidEmail = "invalid-email"
        let password = "Test12345!"

        steps.openLoginFromOnboarding()
        steps.login(email: invalidEmail, password: password)
        steps.assertLoginErrorContains("badly formatted")
    }

    // MARK: - Test case 2

    func testLoginWithUnregisteredAccountShowsError() {
        let unregisteredEmail = uniqueEmail(prefix: "unregistered")
        let password = "Test12345!"

        steps.openLoginFromOnboarding()
        steps.login(email: unregisteredEmail, password: password)
        steps.assertLoginErrorContains("malformed or has expired")
    }

    // MARK: - Test case 3

    func testRegisterLogoutAndLoginAgain() {
        let email = uniqueEmail(prefix: "easybank")
        let password = "StrongPass123!"

        steps.openRegistrationFromOnboarding()
        steps.register(email: email, password: password)
        steps.assertHomeDisplayed()

        steps.logout()
        steps.assertLoginScreenDisplayed()

        steps.login(email: email, password: password)
        steps.assertHomeDisplayed()
    }

    // MARK: - Test data

    private func uniqueEmail(prefix: String) -> String {
        let suffix = UUID().uuidString.prefix(8).lowercased()
        return "\(prefix).\(suffix)@example.com"
    }
}
