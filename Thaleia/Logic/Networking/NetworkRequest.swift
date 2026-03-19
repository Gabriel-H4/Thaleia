//
//  NetworkRequest.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/13/26.
//

import Foundation

extension Network {
    struct Request {
        var url: URL
        var method: Method
        var contentType: ContentType = .json
        var headers: [String: String] = [:]
        
        enum Method: String {
            case get = "GET"
            case post = "POST"
        }
        
        enum ContentType: String {
            case json = "application/json"
        }
        
        var urlRequest: URLRequest {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
            return request
        }
    }
}
