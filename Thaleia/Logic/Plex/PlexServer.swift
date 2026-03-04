//
//  PlexServer.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/4/26.
//

import Foundation

struct PlexServer: Server {
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

    mutating func getStatus() async throws(ThaleiaError) -> PlexServer.Endpoints
        .Status?
    {
        do {
            try await refreshCredentials()
            return try await send(
                Endpoints.GetStatusRequest(token: self.credential.apiKey)
            ).body
        } catch let error as ThaleiaError {
            throw error
        } catch is DecodingError {
            throw ThaleiaError(
                file: #file,
                function: #function,
                line: #line,
                errorDescription: String(
                    localized:
                        "PlexServer.getStatus.decodingError.errorDescription"
                ),
                recoverySuggestion: String(
                    localized:
                        "PlexServer.getStatus.decodingError.recoverySuggestion"
                ),
                failureReason: String(
                    localized:
                        "PlexServer.getStatus.decodingError.failureReason"
                ),
                isFatal: false
            )
        } catch {
            throw ThaleiaError(
                file: #file,
                function: #function,
                line: #line,
                errorDescription: String(
                    localized:
                        "PlexServer.getStatus.other.errorDescription"
                ),
                recoverySuggestion: String(
                    localized:
                        "PlexServer.getStatus.other.recoverySuggestion"
                ),
                failureReason: String(
                    localized: "PlexServer.getStatus.other.failureReason"
                ),
                isFatal: false
            )
        }
    }
}
