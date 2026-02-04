//
//  OverseerrServerTests.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 10/15/25.
//

import Testing
import Thaleia

@MainActor
struct OverseerrServerTests {

    let testServer = OverseerrServer(
        name: "Simple Web Server",
        baseURL: "http://127.0.0.1:8080",
        apiKey: ""
    )
    let headers = ["content-type": "application/json"]

    @Test func getServerStatus() async throws {

        try await testServer.getStatus()

        #expect(
            testServer.status == .connected,
            "Ensure the status endpoint returns a valid JSON response"
        )
    }

    @Test func getServerStatusWithInvalidPath() async throws {
        try await testServer.getStatus("/fake/path/to/test")
        #expect(
            testServer.status == .disconnected,
            "Ensure invalid paths are not treated as valid"
        )
    }
}
