//
//  Server.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/8/26.
//

import SwiftUI

struct Server {

    private(set) var kind: Server.Kind
    private(set) var credential: Keychain.Credential

    var status: Server.ConnectionStatus {
        return .notConfigured
    }

    var isConfigured: Bool {
        return self.credential != Keychain.Credential.empty
    }

    func getStatus() async throws(ThaleiaError) -> Server.ConnectionStatus {
        guard self.isConfigured else {
            return .notConfigured
        }
        switch self.kind {
        case .plex:
            return .notConfigured
        case .seerr:
            let networkResponse = try await Network.getData(
                request: Network.Request(
                    url: self.credential.url.url!,
                    method: .get,
                    contentType: .json,
                    headers: [:]
                ),
                as: SeerrAPI.Status.self
            )
            if networkResponse.version != "" {
                return .connected
            }
            return .disconnected
        }
    }
}

extension Server {
    enum Kind: LabelRepresentable {
        case plex
        case seerr

        var localizedText: String {
            switch self {
            case .plex:
                return String(localized: "Server.Kind.plex")
            case .seerr:
                return String(localized: "Server.Kind.seerr")
            }
        }

        var systemIcon: String {
            switch self {
            case .plex:
                return "film"
            case .seerr:
                return "list.clipboard"
            }
        }
    }

    enum ConnectionStatus: LabelRepresentable {
        case connected
        case disconnected
        case notConfigured

        var localizedText: String {
            switch self {
            case .connected:
                return String(localized: "Server.ConnectionStatus.connected")
            case .disconnected:
                return String(localized: "Server.ConnectionStatus.disconnected")
            case .notConfigured:
                return String(
                    localized: "Server.ConnectionStatus.notConfigured"
                )
            }
        }

        var systemIcon: String {
            switch self {
            case .connected:
                return "checkmark.circle"
            case .disconnected:
                return "xmark.circle"
            case .notConfigured:
                return "questionmark.circle"
            }
        }

        var color: Color {
            switch self {
            case .connected:
                return Color.green.opacity(0.25)
            case .disconnected:
                return Color.red.opacity(0.25)
            case .notConfigured:
                return Color.yellow.opacity(0.25)
            }
        }
    }
}
