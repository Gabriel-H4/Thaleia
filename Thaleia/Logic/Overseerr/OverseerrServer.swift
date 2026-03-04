//
//  OverseerrServer.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/8/26.
//

import Foundation

struct OverseerrServer: Server {

    private(set) var credential: Credential
    var baseURL: URL {
        return credential.url
    }

    mutating func refreshCredentials() async throws(ThaleiaError) {
        if let credentials = try KeychainHandler.perform(
            .get,
            using: credential
        ) {
            self.credential = credentials
        }
    }

    func getStatus() async throws(ThaleiaError) {

    }

}
