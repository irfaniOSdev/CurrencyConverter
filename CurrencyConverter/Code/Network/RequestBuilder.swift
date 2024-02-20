//
//  RequestBuilder.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 12/10/2023.

import Foundation
import Combine

protocol RequestBuilderProtocol {
    func buildRequest(for endpoint: any RequestProvider) -> URLRequest
}

class RequestBuilder: RequestBuilderProtocol {
    
    func buildRequest(for endpoint: any RequestProvider) -> URLRequest {
        var request = URLRequest(url: URL(string: endpoint.absoluteURL)!)
        request.httpMethod = endpoint.requestType.rawValue
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.httpBody = endpoint.requestBody.getBody()
        request.allHTTPHeaderFields = endpoint.headers
        return request
    }
}
