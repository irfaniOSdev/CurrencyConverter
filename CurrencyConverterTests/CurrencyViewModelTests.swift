//
//  CurrencyViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Muhammad Irfan on 03/11/2023.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyViewModelTests: XCTestCase {

    var currencyViewModel: CurrencyViewModel!
    var mockStorage: DataStorage!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockStorage = FileStorage()

        currencyViewModel = CurrencyViewModel(dataService: ConversionRateService(currency: "USD"), storage: mockStorage)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        currencyViewModel = nil
        mockStorage = nil
        try super.tearDownWithError()
    }
    
    func testSaveCurrenciesToStorage(){
        currencyViewModel.saveCurrenciesToStorage(currencies: [CurrencyRate(name: "PKR", value: 282.250)])
        XCTAssertEqual(currencyViewModel.conversions.count > 0, true)
    }
    
    func testLoadCurrenciesFromStorage(){
        currencyViewModel.loadCurrenciesFromStorage()
        XCTAssertEqual(currencyViewModel.conversions.count > 0, true)
    }
    
    func testSelectedCurrency(){
        currencyViewModel.setSelectedCurrency(currency: "USD")
        XCTAssertEqual(currencyViewModel.selectedCurrency?.name ?? "USD", "USD")
    }
    
    func testCorrectCurrencyConversion() throws {
        /// based on 1 USD rate
        let fromCurrency = CurrencyRate(name: "USD", value: 1)
        currencyViewModel.selectedCurrency = fromCurrency
        
        let toCurrency = CurrencyRate(name: "PKR", value: 282.250)
        let convertedCurrency = currencyViewModel.getCurrency(conversion: toCurrency, amountText: "1")
        
        let value = try XCTUnwrap(convertedCurrency.value.isZero)
        XCTAssertFalse(value)
        
        XCTAssertEqual(Double(round(100*convertedCurrency.value)/100), 282.250)
    }
    
    func testWrongCurrencyConversion() throws {
        /// based on 1 USD rate
        let fromCurrency = CurrencyRate(name: "USD", value: 1)
        currencyViewModel.selectedCurrency = fromCurrency
        
        let toCurrency = CurrencyRate(name: "PKR", value: 282.250)
        let convertedCurrency = currencyViewModel.getCurrency(conversion: toCurrency, amountText: "1")
        
        let value = try XCTUnwrap(convertedCurrency.value.isZero)
        XCTAssertFalse(value)
        XCTAssertNotEqual(Double(round(100*convertedCurrency.value)/100), 150.0)
    }
}
