import XCTest

final class BankingFlowTests: BaseClass {
    func testAppLaunch() {
        XCTAssertEqual(app.state, .runningForeground)

        let screenshot = XCTAttachment(screenshot: app.screenshot())
        screenshot.name = "App Launch"
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }
}
