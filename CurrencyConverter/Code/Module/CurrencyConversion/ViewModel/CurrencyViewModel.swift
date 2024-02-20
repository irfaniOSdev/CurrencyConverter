//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 29/10/2023.
//

import Combine
import Foundation

enum Section {
    case main
}

class CurrencyViewModel {
    
    @Published private(set) var conversions: [CurrencyRate] = []

    var selectedCurrency: CurrencyRate? = nil

    private var cancellables: Set<AnyCancellable> = []

    private let dataService: ConversionRateService
    
    let storage: DataStorage
    
    private var timer: Timer?
    
    // Inject the data service through the initializer
    init(dataService: ConversionRateService, storage: DataStorage) {
        self.dataService = dataService
        self.storage = storage
        
        // Schedule a repeating timer to perform the API call every 30 minutes.
        checkCurrencyUpdate()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: currencyRefreshRate, repeats: true) { [weak self] timer in
            self?.checkCurrencyUpdate()
        }
    }
    
    func checkCurrencyUpdate() {
        if isLastCurrencyUpdateAllowed() {
            loadCurrenciesFromStorage()
            return
        }
        getDataFromServer()
    }
    
    func isLastCurrencyUpdateAllowed()-> Bool {
        if let lastTimeInterval = UserDefaults.standard.lastCurrencyUpdateTime(), Date().timeIntervalSince1970 - lastTimeInterval < currencyRefreshRate {
            return true
        }
        return false
    }
    
    func loadCurrenciesFromStorage() {
        if let retrievedCurrencies: [CurrencyRate] = storage.load(fromFile: "currency.json", as: [CurrencyRate].self) {
            conversions.removeAll()
            conversions.append(contentsOf: retrievedCurrencies)
        }
        else {
            print("Failed to load currency rates.")
        }
    }
    
    func saveCurrenciesToStorage(currencies:[CurrencyRate]) {
        if storage.save(currencies, toFile: "currency.json") {
            conversions.removeAll()
            conversions.append(contentsOf: currencies)
            print("Currency rates saved successfully.")
        } else {
            print("Failed to save currency rates.")
        }
    }
    
    func getDataFromServer(){
        Spinner.start()
        dataService.performRequest().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            guard let self else { return }
            UserDefaults.standard.setLastCurrencyUpdateTime(time: Date().timeIntervalSince1970)
            UserDefaults.standard.synchronize()
            self.saveCurrenciesToStorage(currencies: response.getCurrencyRates())
            Spinner.stop()
        })
        .store(in: &cancellables)
    }
    
    func setSelectedCurrency(currency: String?){
        selectedCurrency = conversions.filter { $0.name == currency ?? baseCurrency}.first
    }
    
    func getCurrency(conversion: CurrencyRate, amountText: String) -> CurrencyRate {
        let amount = Double(amountText) ?? 0.0
        let currency = selectedCurrency?.name ?? baseCurrency

        var convertedAmount: Double

        switch (amount, currency) {
        case (0.0, _):
            convertedAmount = conversion.value
        case (_, baseCurrency):
            convertedAmount = amount * conversion.value
        case (_, _):
            let value = conversion.value / (selectedCurrency?.value ?? 0.0)
            convertedAmount = amount * value
        }
        
        return CurrencyRate(name: conversion.name, value: convertedAmount)
    }
}
