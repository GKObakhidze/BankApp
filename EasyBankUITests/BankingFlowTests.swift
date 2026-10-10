import XCTest

final class BankingFlowTests: BaseClass {

    private var steps: EasyBankSteps!

    override func setUp() {
        super.setUp()
        steps = EasyBankSteps(app: app)
    }

    func testLoginWithInvalidEmailFormatShowsError() {
        steps.openLoginForm()
        steps.logIn(email: invalidEmail, password: anyPassword)
        steps.assertLoginError(contains: badlyFormattedText)
    }

    func testLoginWithUnregisteredAccountShowsError() {
        let email = makeUniqueEmail(prefix: unregisteredEmailPrefix)

        steps.openLoginForm()
        steps.logIn(email: email, password: anyPassword)
        steps.assertLoginError(contains: malformedOrExpiredText)
    }

    func testRegisterLogoutAndLoginAgain() {
        let email = makeUniqueEmail(prefix: registrationEmailPrefix)
        let password = strongPassword

        steps.openRegistrationForm()
        steps.registerAccount(email: email, password: password)
        steps.assertHomeDisplayed()

        steps.logOut()
        steps.waitForLoginForm()
        steps.logIn(email: email, password: password)
        steps.assertHomeDisplayed()
    }

    private func makeUniqueEmail(prefix: String) -> String {
        let suffix = UUID().uuidString.lowercased().prefix(emailSuffixLength)
        return "\(prefix)-\(suffix)@\(emailDomain)"
    }
}