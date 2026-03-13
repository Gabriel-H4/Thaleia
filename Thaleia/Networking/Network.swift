//
//  Network.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/13/26.
//

import Foundation

struct Network {
    private init() {}
    
    static func getData(request: Network.Request) async throws {
        let (data, response) = try await Network.Session.session.data(
            for: request.urlRequest
        )
    }
    
    static func sendData(request: Network.Request, data: Data) async throws {
        let (data, response) = try await Network.Session.session.upload(
            for: request.urlRequest,
            from: data
        )
    }
}
