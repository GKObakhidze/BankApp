//
//  BaseClass.swift
//  EasyBankUITests
//
//  Created by lmosakhlishvili on 10.02.25.
//

import XCTest

class BaseClass: XCTestCase {
    private(set) var app = XCUIApplication()
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
    }
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        launchApp()
        app.tap()
    }
    
    fileprivate func launchApp() {
        app = XCUIApplication()
        app.launchArguments.append("UI-Testing")
        app.launch()
    }
    
    func relaunchApp() {
        super.tearDown()
        launchApp()
    }
}
