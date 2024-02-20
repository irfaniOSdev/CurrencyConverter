//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Muhammad Irfan on 29/10/2023.
//

import XCTest
import Combine
@testable import CurrencyConverter


final class CurrencyConverterTests: XCTestCase {

    var mockService: ConversionRateService!
    
    override func setUpWithError() throws {
        mockService = ConversionRateService(currency: "USD")
    }

    override func tearDownWithError() throws {
        mockService = nil
        try super.tearDownWithError()
    }

    func testConversionRateService() {
        let expectation = XCTestExpectation(description: "Currency conversion request")
        let cancellable = mockService.performRequest()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break // Test passed
                case .failure(let error):
                    XCTFail("Request failed with error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { currencyModel in
                // Assert on the received CurrencyModel if needed
                XCTAssertNotNil(currencyModel)
            })
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
        
        // Cleanup and cancel the Combine subscription
        cancellable.cancel()
    }
}
