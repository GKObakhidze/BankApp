import XCTest

class BaseClass: XCTestCase {

    private(set) var app = XCUIApplication()

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("UI-Testing")
        app.launch()
    }

    override func tearDown() {
        if app.state != .notRunning {
            app.terminate()
        }

        super.tearDown()
    }

    func relaunchApp() {
        if app.state != .notRunning {
            app.terminate()
        }

        app = XCUIApplication()
        app.launchArguments.append("UI-Testing")
        app.launch()
    }
}