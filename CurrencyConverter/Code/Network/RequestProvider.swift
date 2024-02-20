//
//  RequestProvider.swift
//  Cheetay
//
//  Created by Muhammad Irfan on 01/10/2021.

//
/**** Request provider helps preparing url request*/

import Foundation

typealias APIParameters = [String : Any]?
typealias HTTPHeaders = [String : String]

enum RequestBodyEncoding {
    case jsonEncoding
    case urlEncoding
}

enum ContentType: String {
    case application
    case form
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

protocol RequestProvider {
    var baseURL: String                          { get }
    var requestType: HttpMethod                  { get }
    var endPoint: String                         { get }
    var parameters: APIParameters                { get }
    var headers: HTTPHeaders                     { get }
    var requestBodyEncoding: RequestBodyEncoding { get }
    var requestBody: RequestBody                 { get }
}

extension RequestProvider {
    
    var baseURL: String {
        return baseUrl
    }
   
    var requestType: HttpMethod {
        return .get
    }
    
    var absoluteURL: String {
        return "\(baseURL)\(endPoint)"
    }
    
    var requestBodyEncoding: RequestBodyEncoding {
        return .jsonEncoding
    }
    
    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: APIParameters {
        return nil
    }
    
    var requestBody: RequestBody {
        return RequestBody(encoding: requestBodyEncoding, parameters: parameters)
    }
}
