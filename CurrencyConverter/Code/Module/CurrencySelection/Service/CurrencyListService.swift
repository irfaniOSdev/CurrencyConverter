//
//  CurrencyListService.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 31/10/2023.
//

import Foundation
import Combine

class CurrencyListService: RequestProvider {
    
    
    var endPoint: String {
        var components = URLComponents()
        components.queryItems = [URLQueryItem(name: "app_id", value: "396509e2622e4eb383644279fbf1ddb3")]
        components.path = EndPoint.getCurrencies.rawValue
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url.absoluteString
    }
    
    var requestType: HttpMethod {
        return .get
    }
}

extension CurrencyListService: NetworkServiceDependency {
    typealias T = [String: String]

    func performRequest() -> AnyPublisher<T, APIError>{
        return service.request(self)
            .eraseToAnyPublisher()
    }
}
