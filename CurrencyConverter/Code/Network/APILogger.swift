//
//  APILogger.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 24/10/2023.

import Foundation
import Combine

extension Publisher where Output == Data {

    func logAPIRequest(request: URLRequest) -> AnyPublisher<Data, Error> {
        let label = "===== API Logs ==="
        return self
            .handleEvents(receiveSubscription: { _ in
                log(request: request)
            }, receiveOutput: { data in
                if let jsonString = String(data: data, encoding: .utf8) {
                    Swift.print("\(label) Received data from the API: \n\n \(jsonString) \n")
                } else {
                    Swift.print("\(label) Received data from the API (not a valid UTF-8 string).")
                }
            }, receiveCompletion: { completion in
                switch completion {
                case .finished:
                    let message = "\n\n\(label) API Request completed successfully."
                    Swift.print(message)
                case .failure(let error):
                    let message = "\n\n\(label) API Request failed with error: \n \(error)"
                    Swift.print(message)
                }
            })
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func log(request: URLRequest) {
        
        Swift.print("\n - - - - - - - - - - Request START - - - - - - - - - - \n")
        defer { Swift.print("\n - - - - - - - - - -Request  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        Swift.print("NetworkLogger_Request \(logOutput)")
    }
}
