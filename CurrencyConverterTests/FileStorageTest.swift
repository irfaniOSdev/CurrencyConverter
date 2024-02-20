//
//  FileStorageTest.swift
//  CurrencyConverterTests
//
//  Created by Muhammad Irfan on 02/11/2023.
//

import XCTest
@testable import CurrencyConverter

final class FileStorageTest: XCTestCase {
    
    // The property to hold the instance of FileStorage
    var fileStorage: FileStorage!
    
    override func setUp() {
        super.setUp()
        fileStorage = FileStorage()
    }
    
    override func tearDown() {
        super.tearDown()
        fileStorage = nil
    }
    
    func testSaveAndLoadData() {
        // Test data to be saved and loaded
        struct TestData: Codable {
            let currency: String
            let rate: Double
        }
        
        let testData = TestData(currency: "USD", rate: 1.0)
        let fileName = "testData.json"
        
        // Save the test data
        XCTAssertTrue(fileStorage.save(testData, toFile: fileName))
        
        // Load the saved data and check if it matches the original data
        if let loadedData: TestData = fileStorage.load(fromFile: fileName, as: TestData.self) {
            XCTAssertEqual(loadedData.currency, testData.currency)
            XCTAssertEqual(loadedData.rate, testData.rate)
        } else {
            XCTFail("Failed to load data from the file.")
        }
    }
    
    func testLoadNonExistentFile() {
        let fileName = "empty.json"
        let loadedData: String? = fileStorage.load(fromFile: fileName, as: String.self)
        XCTAssertNil(loadedData, "Loaded data should be nil for empty file.")
    }
}
