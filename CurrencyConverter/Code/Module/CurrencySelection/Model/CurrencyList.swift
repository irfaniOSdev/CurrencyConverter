//
//  CurrencyList.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 31/10/2023.
//

import Foundation

struct CurrencyDetail: Hashable {
    var name: String
    var value: String
    
    func getFullName()-> String {
        return "\(name) : \(value)"
    }
}
struct CurrencyList {
    
    let dictionary: [String: String]
    
    init(dictionary: [String: String]) {
        self.dictionary = dictionary
    }
    
    typealias CurrencyCodes = [CurrencyDetail]
    
    func getCurrencyList() -> CurrencyCodes {
        return self.dictionary.keys.map { CurrencyDetail(name: $0, value: self.dictionary[$0] ?? "") }.sorted { $0.name < $1.name }
    }
}
