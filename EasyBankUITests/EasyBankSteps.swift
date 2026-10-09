//
//  EasyBankSteps.swift
//  EasyBankUITests
//
//  Created by Mariam Keknadze on 09.10.26.
//

import Foundation

import XCTest

class EasyBankSteps {
    let page: EasyBankPage

    init(page: EasyBankPage) {
        self.page = page
    }

    // MARK: - Onboarding Actions

    @discardableResult
    func tapOnboardingLogin(timeout: TimeInterval = 10) -> EasyBankSteps {
        XCTAssertTrue(page.onboardingLoginButton.waitForExistence(timeout: timeout), "Onboarding Log In button did not appear")
        page.onboardingLoginButton.tap()
        return self
    }

    @discardableResult
    func tapOnboardingRegister(timeout: TimeInterval = 10) -> EasyBankSteps {
        XCTAssertTrue(page.onboardingRegisterButton.waitForExistence(timeout: timeout), "Onboarding Register button did not appear")
        page.onboardingRegisterButton.tap()
        return self
    }

    // MARK: - Login Actions

    @discardableResult
    func enterLoginEmail(_ email: String, timeout: TimeInterval = 10) -> EasyBankSteps {
        XCTAssertTrue(page.loginEmailTextField.waitForExistence(timeout: timeout), "Login email text field did not appear")
        page.loginEmailTextField.tap()
        page.loginEmailTextField.typeText(email)
        return self
    }

    @discardableResult
    func enterLoginPassword(_ password: String, timeout: TimeInterval = 10) -> EasyBankSteps {
        XCTAssertTrue(page.loginPasswordTextField.waitForExistence(timeout: timeout), "Login password text field did not appear")
        page.loginPasswordTextField.tap()
        page.loginPasswordTextField.typeText(password)
        return self
    }

    @discardableResult
    func tapLoginSubmit(timeout: TimeInterval = 10) -> EasyBankSteps {
        XCTAssertTrue(page.loginSubmitButton.waitForExistence(timeout: timeout), "Login submit button did not appear")
        page.loginSubmitButton.tap()
        return self
    }

    // MARK: - Registration Actions

    @discardableResult
    func enterRegistrationEmail(_ email: String, timeout: TimeInterval = 10) -> EasyBankSteps {
        XCTAssertTrue(page.registrationEmailTextField.waitForExistence(timeout: timeout), "Registration email field did not appear")
        page.registrationEmailTextField.tap()
        page.registrationEmailTextField.typeText(email)
        return self
    }

    @discardableResult
    func enterRegistrationPassword(_ password: String, timeout: TimeInterval = 10) -> EasyBankSteps {
        typeWithPasswordToggle(identifier: "registration.password", text: password, timeout: timeout)
        return self
    }

    @discardableResult
    func enterRegistrationRepeatPassword(_ password: String, timeout: TimeInterval = 10) -> EasyBankSteps {
        typeWithPasswordToggle(identifier: "registration.repeatPassword", text: password, timeout: timeout)
        return self
    }

    @discardableResult
    func tapRegistrationSubmit(timeout: TimeInterval = 10) -> EasyBankSteps {
        XCTAssertTrue(page.registrationSubmitButton.waitForExistence(timeout: timeout), "Registration submit button did not appear")
        page.registrationSubmitButton.tap()
        return self
    }

    // MARK: - Home Actions & Logout

    @discardableResult
    func tapHomeLogout(timeout: TimeInterval = 10) -> EasyBankSteps {
        XCTAssertTrue(page.homeLogoutButton.waitForExistence(timeout: timeout), "Home logout button did not appear")
        page.homeLogoutButton.tap()
        return self
    }

    @discardableResult
    func confirmLogout(timeout: TimeInterval = 10) -> EasyBankSteps {
        XCTAssertTrue(page.logoutAlert.waitForExistence(timeout: timeout), "Logout confirmation alert did not appear")
        XCTAssertTrue(page.logoutConfirmButton.waitForExistence(timeout: timeout), "Yes button in logout alert did not appear")
        page.logoutConfirmButton.tap()
        return self
    }

    // MARK: - Assertions

    @discardableResult
    func assertLoginErrorContains(_ expectedText: String, timeout: TimeInterval = 10) -> EasyBankSteps {
        XCTAssertTrue(page.loginErrorLabel.waitForExistence(timeout: timeout), "Login error label did not appear")
        let actualText = page.loginErrorLabel.label
        XCTAssertTrue(
            actualText.localizedCaseInsensitiveContains(expectedText),
            "Expected error message to contain '\(expectedText)', but found '\(actualText)'"
        )
        return self
    }

    @discardableResult
    func assertLoginErrorContainsAny(_ fragments: [String], timeout: TimeInterval = 10) -> EasyBankSteps {
        XCTAssertTrue(page.loginErrorLabel.waitForExistence(timeout: timeout), "Login error label did not appear")
        let actualText = page.loginErrorLabel.label
        let matches = fragments.contains { actualText.localizedCaseInsensitiveContains($0) }
        XCTAssertTrue(
            matches,
            "Expected error message to contain one of \(fragments), but found '\(actualText)'"
        )
        return self
    }

    @discardableResult
    func assertHomeScreenDisplayed(timeout: TimeInterval = 10) -> EasyBankSteps {
        let isHomeVisible = page.homeSendMoneyButton.waitForExistence(timeout: timeout) || page.homeTabButton.waitForExistence(timeout: timeout)
        XCTAssertTrue(isHomeVisible, "Main screen (Home) was not displayed")
        return self
    }

    // MARK: - Helpers

        private func typeWithPasswordToggle(identifier: String, text: String, timeout: TimeInterval) {
            let secureField = page.app.secureTextFields[identifier]
            let textField = page.app.textFields[identifier]

            let exists = secureField.waitForExistence(timeout: timeout) || textField.waitForExistence(timeout: timeout)
            XCTAssertTrue(exists, "Password field '\(identifier)' did not appear")

        
            if secureField.exists {
                let toggleButton = secureField.buttons.element(boundBy: 0)
                if toggleButton.exists {
                    toggleButton.tap()
                }
            }

            if textField.exists {
                textField.tap() 
                textField.typeText(text)
            } else if secureField.exists {
                secureField.tap()
                secureField.typeText(text)
            }
        }}
