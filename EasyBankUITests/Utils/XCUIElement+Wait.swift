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

    func waitForValue(_ value: String, timeout: TimeInterval) -> Bool {
        let predicate = NSPredicate { element, _ in
            ((element as? XCUIElement)?.value as? String) == value
        }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }

    func waitForValueLength(_ length: Int, timeout: TimeInterval) -> Bool {
        let predicate = NSPredicate { element, _ in
            ((element as? XCUIElement)?.value as? String)?.count == length
        }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
}
