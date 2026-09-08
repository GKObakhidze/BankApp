//
//  PageClasss.swift
//  EasyBankUITests
//
//  Created by lmosakhlishvili on 10.02.25.
//

import XCTest

class PageClasss: BaseClass {
    
    var studentOffer: XCUIElement { app.staticTexts["Student"] }
    var logInBtn: XCUIElement { app.buttons["Log In"] }

}
