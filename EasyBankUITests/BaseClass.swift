//
//  BaseClass.swift
//  EasyBankUITests
//
//  Created by lmosakhlishvili on 10.02.25.
//


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

    func relaunchApp() {
        app.terminate()
        app.launch()
    }
}
