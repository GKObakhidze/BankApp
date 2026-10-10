//
//  EasyBankSteps.swift
//  EasyBankUITests
//

import XCTest

final class EasyBankSteps {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var onboarding: OnboardingSteps { OnboardingSteps(app: app) }
}
