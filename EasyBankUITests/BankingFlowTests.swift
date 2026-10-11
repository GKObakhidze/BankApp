import XCTest

final class BankingFlowTests: BaseClass {
    private var steps: EasyBankSteps!

    override func setUp() {
        super.setUp()
        steps = EasyBankSteps(app: app)
    }

    func testLoginWithInvalidEmailFormatShowsError() {
        steps
            .openLoginForm()
            .logIn(email: TestData.invalidEmail, password: TestData.password)
            .validateLoginError(contains: TestData.badlyFormattedError)
    }

    func testLoginWithUnregisteredAccountShowsError() {
        steps
            .openLoginForm()
            .logIn(email: TestData.uniqueEmail(), password: TestData.password)
            .validateLoginError(contains: TestData.invalidCredentialsError)
    }

    func testRegisterLogOutAndLogInAgain() {
        let email = TestData.uniqueEmail()

        steps
            .openRegistrationForm()
            .register(email: email, password: TestData.password)
            .validateHomeIsDisplayed()
            .logOut()
            .logIn(email: email, password: TestData.password)
            .validateHomeIsDisplayed()
    }
}

private enum TestData {
    static let invalidEmail = "invalid-email"
    // Registration only asks for six characters; this one also satisfies any stricter policy.
    static let password = "EasyBank#2026"

    static let badlyFormattedError = "badly formatted"
    static let invalidCredentialsError = "malformed or has expired"

    // Every run starts on a fresh simulator, and an address is never reused within a run,
    // so a generated one is guaranteed to be unregistered until the test registers it.
    static func uniqueEmail() -> String {
        "easybank.\(UUID().uuidString.prefix(8).lowercased())@example.com"
    }
}
