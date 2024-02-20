//
//  LocalStorage.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 01/11/2023.
//

import Foundation

protocol DataStorage {
    func save<T: Codable>(_ data: T, toFile fileName: String) -> Bool
    func load<T: Codable>(fromFile fileName: String, as type: T.Type) -> T?
    
}

class FileStorage: DataStorage {
   
    private let fileManager = FileManager.default

    func save<T: Codable>(_ data: T, toFile fileName: String) -> Bool {
        do {
            let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent(fileName)

            let data = try JSONEncoder().encode(data)
            try data.write(to: fileURL)

            return true
        } catch {
            print("Error saving data to file: \(error)")
            return false
        }
    }

    func load<T: Codable>(fromFile fileName: String, as type: T.Type) -> T? {
        do {
            let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent(fileName)

            let data = try Data(contentsOf: fileURL)
            let loadedData = try JSONDecoder().decode(T.self, from: data)

            return loadedData
        } catch {
            print("Error loading data from file: \(error)")
            return nil
        }
    }
}
