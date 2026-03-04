//
//  Server.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/8/26.
//

import RequestSpec

protocol Server: NetworkService {
    var credential: Credential { get }

    mutating func refreshCredentials() async throws(ThaleiaError)
}
