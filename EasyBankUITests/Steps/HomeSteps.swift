//
//  HomeSteps.swift
//  EasyBankUITests
//

import XCTest

final class HomeSteps: BaseSteps {
    @discardableResult
    func assertDisplayed() -> Self {
        XCTAssertTrue(page.home.sendMoneyButton.waitForExistence(timeout: timeout), "Send Money button is not shown")
        XCTAssertTrue(page.home.homeTab.exists, "Home tab is not shown")
        return self
    }

    func logOut() -> LoginSteps {
        tap(page.home.logoutButton)
        XCTAssertTrue(page.logoutAlert.alert.waitForExistence(timeout: timeout), "Logging Out dialog did not appear")
        tap(page.logoutAlert.confirmButton)
        return LoginSteps(app: app)
    }
}
