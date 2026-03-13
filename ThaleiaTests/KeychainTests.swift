//
//  KeychainTests.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/3/26.
//

import Foundation
import Testing

@testable import Thaleia

struct KeychainTests {

    let keychainHandler = KeychainHandler()
    let credential = Credential(
        username: "demouser",
        apiKey: "key123",
        url: ThaleiaURL(string: "https://example.com:40123")
    )

    @Test func saveCredential() async throws {
        let operation = KeychainHandler.Operation.save
        let result = try KeychainHandler.perform(operation, using: credential)
        #expect(result == nil)
    }

    @Test func getCredential() async throws {
        let operation = KeychainHandler.Operation.get
        let result = try KeychainHandler.perform(operation, using: credential)
        #expect(
            result?.username == credential.username
                && result?.apiKey == credential.apiKey
                && result?.url == credential.url
        )

    }

}
