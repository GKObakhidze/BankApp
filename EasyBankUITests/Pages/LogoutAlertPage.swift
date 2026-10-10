//
//  LogoutAlertPage.swift
//  EasyBankUITests
//

import XCTest

final class LogoutAlertPage: BasePage {
    var alert: XCUIElement { app.alerts[Constants.Label.logoutAlertTitle] }
    var confirmButton: XCUIElement { alert.buttons[Constants.Label.logoutConfirm] }
}
