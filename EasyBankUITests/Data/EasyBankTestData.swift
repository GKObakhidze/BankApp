//
//  EasyBankTestData.swift
//  EasyBankUITests
//

import Foundation

enum EasyBankTestData {
    static func newAccountEmail() -> String {
        uniqueEmail(prefix: EasyBankConstants.Credentials.registeredEmailPrefix)
    }

    static func unregisteredEmail() -> String {
        uniqueEmail(prefix: EasyBankConstants.Credentials.unregisteredEmailPrefix)
    }

    // Digits only after the prefix: the address stays unique per run and is not touched by autocorrection.
    private static func uniqueEmail(prefix: String) -> String {
        let timestamp = Int(Date().timeIntervalSince1970 * 1000)
        let suffix = Int.random(in: 1000...9999)
        return "\(prefix)\(timestamp)\(suffix)@\(EasyBankConstants.Credentials.emailDomain)"
    }
}
