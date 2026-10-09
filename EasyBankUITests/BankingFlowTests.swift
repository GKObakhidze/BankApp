import XCTest

final class BankingFlowTests: BaseClass {
    func testInvalidEmailFormatShowsValidationError() throws {
        try steps.openLogin()
        try steps.logIn(email: "invalid-email", password: "BankTraining9!Strong")
        try steps.assertAuthenticationError(containing: "badly formatted")
    }

    func testUnregisteredEmailShowsAuthenticationError() throws {
        let email = "unregistered-\(UUID().uuidString.lowercased())@example.com"

        try steps.openLogin()
        try steps.logIn(email: email, password: "BankTraining9!Strong")
        try steps.assertAuthenticationError(containing: "malformed or has expired")
    }

    func testRegisteredAccountCanLogOutAndLogInAgain() throws {
        let email = "training-\(UUID().uuidString.lowercased())@example.com"
        let password = "BankTraining9!Strong"

        try steps.openRegistration()
        try steps.register(email: email, password: password)
        try steps.assertHomeDisplayed()
        try steps.logOut()
        try steps.logIn(email: email, password: password)
        try steps.assertHomeDisplayed()
    }
}
