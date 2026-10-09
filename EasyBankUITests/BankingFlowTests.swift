import XCTest

final class BankingFlowTests: BaseClass {

    private var steps: EasyBankSteps { EasyBankSteps(app: app) }

    /// Unique per run, so the registration scenario never collides with an existing account.
    private func uniqueTestEmail() -> String {
        "easybank.\(UUID().uuidString.prefix(8).lowercased())@example.com"
    }

    private let testPassword = "Test1234!"

    // MARK: - Test case 1 — Invalid email format

    func testLoginWithInvalidEmailFormatShowsFormatError() {
        steps.assertOnboardingDisplayed()
        steps.tapLoginOnOnboarding()

        steps.logIn(email: "invalid-email", password: testPassword)

        steps.assertLoginErrorContains("badly formatted")
    }

    // MARK: - Test case 2 — Invalid login credentials

    func testLoginWithUnregisteredCredentialsShowsAuthenticationError() {
        steps.assertOnboardingDisplayed()
        steps.tapLoginOnOnboarding()

        steps.logIn(email: uniqueTestEmail(), password: testPassword)

        steps.assertLoginErrorContains("malformed or has expired")
    }

    // MARK: - Test case 3 — Register, log out, and log in

    func testRegisterThenLogOutThenLogInAgain() {
        let email = uniqueTestEmail()

        steps.assertOnboardingDisplayed()
        steps.tapRegisterOnOnboarding()

        steps.register(email: email, password: testPassword)
        steps.assertMainScreenDisplayed()

        steps.logOut()

        steps.logIn(email: email, password: testPassword)
        steps.assertMainScreenDisplayed()
    }
}
