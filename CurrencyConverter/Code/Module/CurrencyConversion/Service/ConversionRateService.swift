//
//  ConversionRateService.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 12/10/2023.

import Foundation
import Combine

class ConversionRateService: RequestProvider {
    
    let currency : String
    
    init(currency: String) {
        self.currency = currency
    }
    
    var endPoint: String {
        var components = URLComponents()
        components.queryItems = [URLQueryItem(name: "app_id", value: apiAccessKey),
                                 URLQueryItem(name: "base", value: currency)]
        components.path = EndPoint.getConversions.rawValue
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url.absoluteString
    }
    
    var requestType: HttpMethod {
        return .get
    }
}

extension ConversionRateService: NetworkServiceDependency {
    typealias T = CurrencyModel

    func performRequest() -> AnyPublisher<T, APIError>{
        return service.request(self)
            .eraseToAnyPublisher()
    }
}
