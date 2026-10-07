import Foundation
import CryptoKit

enum AppEnvironment {
    static let isTraining = !ProcessInfo.processInfo.arguments.contains("--use-live-services")
}

/// Local data for the teaching app. This is not a banking or production authentication service.
final class TrainingStore {
    static let shared = TrainingStore()
    private struct Account: Codable {
        var user: User
        let salt: String
        let passwordDigest: String
    }
    private struct State: Codable {
        var accounts: [Account] = []
        var transactions: [Transaction] = []
    }
    private let defaults: UserDefaults
    private let storageKey = "easybank.training.v1"
    private var state: State
    private(set) var currentUserID: String?

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        state = defaults.data(forKey: storageKey).flatMap { try? JSONDecoder().decode(State.self, from: $0) } ?? State()
    }

    var currentUser: User? { state.accounts.first { $0.user.id == currentUserID }?.user }
    var users: [User] { state.accounts.map(\.user) }

    private func error(_ message: String) -> NSError {
        NSError(domain: "EasyBankTraining", code: 1, userInfo: [NSLocalizedDescriptionKey: message])
    }
    private func normalizedEmail(_ email: String) -> String {
        email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    private func validateEmail(_ email: String) throws {
        guard email.range(of: #"^[^\s@]+@[^\s@]+\.[^\s@]+$"#, options: .regularExpression) != nil else {
            throw error("The email address is badly formatted.")
        }
    }
    private func digest(_ password: String, salt: String) -> String {
        SHA256.hash(data: Data((salt + password).utf8)).map { String(format: "%02x", $0) }.joined()
    }
    private func save(_ next: State) throws {
        let data = try JSONEncoder().encode(next)
        defaults.set(data, forKey: storageKey)
        state = next
    }

    func register(email: String, password: String) throws {
        let email = normalizedEmail(email)
        try validateEmail(email)
        guard password.count >= 6 else { throw error("The password must be 6 characters long or more.") }
        guard !users.contains(where: { $0.email == email }) else { throw error("The email address is already in use by another account.") }
        let id = UUID().uuidString
        let name = String(email.split(separator: "@")[0])
        let card = Card(id: UUID().uuidString, balance: 0, expiryDate: "12/30", cardHolderName: name, type: "Visa")
        let user = User(id: id, email: email, name: name, cards: [card])
        let salt = UUID().uuidString
        var next = state
        next.accounts.append(Account(user: user, salt: salt, passwordDigest: digest(password, salt: salt)))
        try save(next)
        currentUserID = id
    }

    func login(email: String, password: String) throws {
        let email = normalizedEmail(email)
        try validateEmail(email)
        guard let account = state.accounts.first(where: { $0.user.email == email }),
              account.passwordDigest == digest(password, salt: account.salt) else {
            throw error("The supplied auth credential is incorrect, malformed or has expired.")
        }
        currentUserID = account.user.id
    }
    func logout() { currentUserID = nil }
    func requireCurrentUser() throws -> User {
        guard let user = currentUser else { throw error("Please log in.") }
        return user
    }
    func updateUser(_ user: User) throws {
        guard user.id == currentUserID, let index = state.accounts.firstIndex(where: { $0.user.id == user.id }) else {
            throw error("Please log in to update this account.")
        }
        var next = state
        next.accounts[index].user = user
        try save(next)
    }
    func updateCard(userID: String, cardID: String, change: (inout Card) -> Void) throws {
        var user = try requireCurrentUser()
        guard user.id == userID, let index = user.cards.firstIndex(where: { $0.id == cardID }) else { throw error("Card not found.") }
        change(&user.cards[index])
        guard user.cards[index].balance.isFinite, user.cards[index].balance >= 0 else { throw error("Enter a valid balance.") }
        try updateUser(user)
    }
    func deleteCard(userID: String, cardID: String) throws {
        var user = try requireCurrentUser()
        guard user.id == userID, user.cards.contains(where: { $0.id == cardID }) else { throw error("Card not found.") }
        user.cards.removeAll { $0.id == cardID }
        try updateUser(user)
    }
    func transactions(for userID: String) -> [Transaction] {
        state.transactions.filter { $0.fromUserId == userID || $0.toUserId == userID }
    }
    func sendMoney(fromCardID: String, toCardID: String, amount: Double) throws {
        guard amount.isFinite, amount > 0, fromCardID != toCardID else { throw error("Enter a positive amount and a different destination card.") }
        guard let from = state.accounts.firstIndex(where: { $0.user.id == currentUserID && $0.user.cards.contains { $0.id == fromCardID } }),
              let to = state.accounts.firstIndex(where: { $0.user.cards.contains { $0.id == toCardID } }),
              let fromCard = state.accounts[from].user.cards.firstIndex(where: { $0.id == fromCardID }),
              let toCard = state.accounts[to].user.cards.firstIndex(where: { $0.id == toCardID }) else { throw error("Card not found.") }
        guard state.accounts[from].user.cards[fromCard].balance >= amount else { throw error("Insufficient balance.") }
        var next = state
        next.accounts[from].user.cards[fromCard].balance -= amount
        next.accounts[to].user.cards[toCard].balance += amount
        next.transactions.append(Transaction(fromUserId: next.accounts[from].user.id, toUserId: next.accounts[to].user.id,
            fromCardId: fromCardID, toCardId: toCardID, amount: amount, timestamp: Date(), iconName: "TransactionCellImage"))
        try save(next)
    }
}
