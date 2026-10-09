import XCTest

class BaseClass: XCTestCase {
    private(set) var app = XCUIApplication()
    private(set) var steps: EasyBankSteps!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UI-Testing", "-AppleLanguages", "(en)", "-AppleLocale", "en_US"]
        app.launch()
        steps = EasyBankSteps(page: EasyBankPage(app: app))
        try steps.assertOnboardingDisplayed()
    }

    override func tearDownWithError() throws {
        app.terminate()
        steps = nil
        try super.tearDownWithError()
    }
}
