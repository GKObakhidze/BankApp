//
//  OnboardingSteps.swift
//  EasyBankUITests
//

import XCTest

final class OnboardingSteps: BaseSteps {
    func openLogin() -> LoginSteps {
        tap(page.onboarding.loginButton)
        return LoginSteps(app: app)
    }

    func openRegistration() -> RegistrationSteps {
        tap(page.onboarding.registerButton)
        return RegistrationSteps(app: app)
    }
}
