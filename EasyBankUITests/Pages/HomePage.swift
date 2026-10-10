//
//  HomePage.swift
//  EasyBankUITests
//

import XCTest

final class HomePage: BasePage {
    var homeTab: XCUIElement { app.tabBars.buttons[Constants.Label.homeTab] }
    var sendMoneyButton: XCUIElement { app.buttons[Constants.Identifier.homeSendMoney] }
    var logoutButton: XCUIElement { app.buttons[Constants.Identifier.homeLogout] }
}
