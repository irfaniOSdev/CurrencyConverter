//
//  APIError.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 13/10/2023.

enum NetworkError: Error {
    case invalidURL
    case serverError(Error)
}

enum APIError: Error {
    case networkError(NetworkError)
    case decodingError(DecodingError)
    case customError(String)
}

extension APIError {
    var localizedDescription: String {
        switch self {
        case .networkError(let networkError):
            return networkError.localizedDescription
        case .decodingError(let decodingError):
            return decodingError.localizedDescription
        case .customError(let message):
            return message
            // Handle other error cases if necessary
        }
    }
}
