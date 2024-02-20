//
//  NetworkServiceDependency.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 16/10/2023.

import Combine

protocol NetworkServiceDependency {
    associatedtype T: Decodable
    var service: NetworkServiceProtocol { get }
    func performRequest() -> AnyPublisher<T, APIError>
}

extension NetworkServiceDependency {
    
    var service: NetworkServiceProtocol {
        return NetworkService(networkManager: NetworkManager())
    }    
}
