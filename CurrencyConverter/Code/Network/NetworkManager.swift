//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 12/10/2023.

import Combine
import Foundation
protocol NetworkManagerProtocol {
    func request(_ request: URLRequest) -> AnyPublisher<Data, Error>
}

class NetworkManager: NetworkManagerProtocol {
    
    func request(_ request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .logAPIRequest(request: request)
            .mapError { error -> Error in
                            // Map URLSession errors or handle them as needed
                            return error
                        }
            .eraseToAnyPublisher()
    }
}
