//
//  EasyBankPage.swift
//  EasyBankUITests
//

import XCTest

final class EasyBankPage {
    let onboarding: OnboardingPage
    let login: LoginPage
    let registration: RegistrationPage
    let home: HomePage
    let logoutAlert: LogoutAlertPage
    let system: SystemPage

    init(app: XCUIApplication) {
        onboarding = OnboardingPage(app: app)
        login = LoginPage(app: app)
        registration = RegistrationPage(app: app)
        home = HomePage(app: app)
        logoutAlert = LogoutAlertPage(app: app)
        system = SystemPage(app: app)
    }
}
