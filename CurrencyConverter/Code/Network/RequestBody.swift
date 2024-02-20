//
//  RequestBody.swift
//  Cheetay
//
//  Created by Muhammad Irfan on 25/03/2022.
import Foundation

class RequestBody {
    
    private let encoding: RequestBodyEncoding
    private let parameters: APIParameters
    
    init(encoding: RequestBodyEncoding, parameters: APIParameters) {
        self.encoding = encoding
        self.parameters = parameters
    }
    
    func getBody()-> Data? {
        guard let parameters = parameters else {
            return nil
        }
        switch encoding {
        case .jsonEncoding:
           return try? JSONSerialization.data(withJSONObject:parameters, options: [])
        case .urlEncoding:
            return encodeParameters(parameters: parameters)
        }
    }
    
    private func percentEscapeString(_ string: Any) -> String {
        
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        let stringConvert = "\(string)"
        return stringConvert
            .addingPercentEncoding(withAllowedCharacters: characterSet) ?? stringConvert
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
    
    private func encodeParameters(parameters: [String : Any]) -> Data? {
        let converted = parameters.compactMapValues { $0}
        let parameterArray = converted.map { (arg) -> String in
            let (key, value) = arg
            return "\(key)=\(self.percentEscapeString(value))"
        }
        return parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
}
