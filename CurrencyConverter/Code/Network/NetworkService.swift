//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 12/10/2023.

import Foundation
import Combine

// Define a protocol for the network service
protocol NetworkServiceProtocol {
    func request<T>(_ endpoint: any RequestProvider) -> AnyPublisher<T, APIError> where T : Decodable
}

// Implement the NetworkService conforming to the protocol
public class NetworkService: NetworkServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    // Mapping errors and decoding objects to codable
    func request<T>(_ endpoint: any RequestProvider) -> AnyPublisher<T, APIError> where T : Decodable {
        
        let request = RequestBuilder().buildRequest(for: endpoint)
        return networkManager.request(request)
            .mapError { error -> APIError in
                return .networkError(.serverError(error))
            }
            .tryMap { data in
                return try JSONDecoder().decode(T.self, from: data)
             }
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return .decodingError(decodingError)
                } else {
                    return .customError(error.localizedDescription)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
