//
//  XCUIElement+Wait.swift
//  EasyBankUITests
//

import XCTest

extension XCUIElement {
    func waitUntilHittable(timeout: TimeInterval) -> Bool {
        let predicate = NSPredicate(format: "exists == true AND isHittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
}
