//
//  CurrencyViewModel.swift
//  EasyBank
//
//  Created by Zuka Papuashvili on 12.07.24.
//

import Foundation

protocol CurrencyViewModelDelegate: AnyObject {
    func didUpdateCurrencies()
    func didEncounterError(_ error: String)
}

class CurrencyViewModel {
    weak var delegate: CurrencyViewModelDelegate?
    
    private var allCurrencies: [Currency] = []
    var currenciesGrouped: [String: [Currency]] = [:]
    var sectionTitles: [String] = []
    
    func fetchCurrencies() {
        if AppEnvironment.isTraining {
            allCurrencies = [("USD", 1.0), ("EUR", 0.9), ("GEL", 2.7)].map {
                Currency(code: $0.0, name: "\(currencyName(for: $0.0)) (sample)", rate: $0.1, iconURL: "")
            }
            filterCurrencies(with: "")
            return
        }
        let urlString = "\(Constants.API.currencyAPIBaseURL)\(Constants.API.ratesEndpoint)?apikey=\(Constants.API.currencyAPIKey)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let result: Result<CurrencyAPIResponse, Error> = Result {
                if let error = error { throw error }
                guard let response = response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode), let data = data else {
                    throw URLError(.badServerResponse)
                }
                return try JSONDecoder().decode(CurrencyAPIResponse.self, from: data)
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.allCurrencies = response.rates.compactMap { key, value in
                        guard let rate = Double(value) else { return nil }
                        return Currency(code: key, name: self.currencyName(for: key), rate: rate, iconURL: self.iconURL(for: key))
                    }
                    self.filterCurrencies(with: "")
                case .failure(let error):
                    self.delegate?.didEncounterError(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func filterCurrencies(with searchText: String) {
        if searchText.isEmpty {
            currenciesGrouped = Dictionary(grouping: allCurrencies, by: { String($0.name.prefix(1)) })
        } else {
            currenciesGrouped = Dictionary(grouping: allCurrencies.filter { $0.code.lowercased().contains(searchText.lowercased()) || $0.name.lowercased().contains(searchText.lowercased()) }, by: { String($0.name.prefix(1)) })
        }
        sectionTitles = currenciesGrouped.keys.sorted()
        delegate?.didUpdateCurrencies()
    }
    
    private func currencyName(for code: String) -> String {
        return Locale.current.localizedString(forCurrencyCode: code) ?? code
    }
    
    private func iconURL(for code: String) -> String {
        return "https://currencyfreaks.com/photos/flags/\(code.lowercased()).png"
    }
}
