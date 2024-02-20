//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 29/10/2023.
//
import Foundation

struct CurrencyRate: Hashable, Codable {
    var name: String
    var value: Double
}

public struct CurrencyModel: Codable, Hashable {
  public let base: String
  public let rates: [String: Double]
}

extension CurrencyModel {
        
    func getCurrencyRates() -> [CurrencyRate] {
        return self.rates.keys.map { CurrencyRate(name: $0, value: self.rates[$0] ?? 0.0) }.sorted { $0.name < $1.name }
    }
}

