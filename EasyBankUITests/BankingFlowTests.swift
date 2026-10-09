import XCTest

final class BankingFlowTests: BaseClass {
    func testAppLaunch() {
        XCTAssertEqual(app.state, .runningForeground)
        
        let screenshot = XCTAttachment(screenshot: app.screenshot())
        screenshot.name = "App Launch"
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }
    
    private var page: EasyBankPage!
    private var steps: EasyBankSteps!
    
    override func setUp() {
        super.setUp()
        page = EasyBankPage(app: app)
        steps = EasyBankSteps(page: page)
    }
    
    // Test case 1 — Invalid email format
    func testInvalidEmailFormat() {
        let invalidEmail = "invalid-email"
        let password = "Password123"
        let expectedErrorMessage = "badly formatted"
        
        steps
            .tapOnboardingLogin()
            .enterLoginEmail(invalidEmail)
            .enterLoginPassword(password)
            .tapLoginSubmit()
            .assertLoginErrorContains(expectedErrorMessage)
    }
    
    // Test case 2 — Invalid login credentials
    func testInvalidLoginCredentials() {
        let unregisteredEmail = "unregistered_\(UUID().uuidString.prefix(6))@example.com"
        let password = "Password123"
        let expectedFragments = ["malformed", "has expired"]
        
        steps
            .tapOnboardingLogin()
            .enterLoginEmail(unregisteredEmail)
            .enterLoginPassword(password)
            .tapLoginSubmit()
            .assertLoginErrorContainsAny(expectedFragments)
    }
    
    // Test case 3 — Register, log out, and log in
    func testRegisterLogoutAndLogin() {
        let uniqueEmail = "user_\(UUID().uuidString.prefix(8))@example.com"
        let strongPassword = "Password123"
        
        steps
            .tapOnboardingRegister()
            .enterRegistrationEmail(uniqueEmail)
            .enterRegistrationPassword(strongPassword)
            .enterRegistrationRepeatPassword(strongPassword)
            .tapRegistrationSubmit()
            .assertHomeScreenDisplayed()
            .tapHomeLogout()
            .confirmLogout()
            .enterLoginEmail(uniqueEmail)
            .enterLoginPassword(strongPassword)
            .tapLoginSubmit()
            .assertHomeScreenDisplayed()
    }
}
