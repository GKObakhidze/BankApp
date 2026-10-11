//
//  HomePage.swift
//  EasyBankUITests
//

import XCTest

final class HomePage: BasePage {
    var homeTab: XCUIElement { app.tabBars.buttons[Constants.Label.homeTab] }
    var sendMoneyButton: XCUIElement { app.buttons["home.sendMoney"] }
    var logoutButton: XCUIElement { app.buttons["home.logout"] }
}
