//
//  Server.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/8/26.
//

import Foundation
import OSLog
import SwiftUI

@available(*, deprecated, renamed: "Server")
struct Server_Old: Identifiable {

    var id: UUID = UUID()
    var kind: Server_Old.Kind
    var credential: Keychain.Credential

    //    var isConfigured: Bool {
    //        return self.credential != Keychain.Credential.empty
    //    }

    var error: ThaleiaError? = nil
    var errorViewIsShowing: Bool {
        get {
            return self.error != nil
        }

        set(newValue) {
            if !newValue {
                self.error = nil
            }
        }
    }

    var status: ConnectionStatus {
        get async throws(ThaleiaError) {
            let server = self
            Logger.Thaleia.viewModel.logger
                .info(
                    "Refreshing status for server: \(server.credential.url.string, privacy: .public)"
                )
            if self.credential == Keychain.Credential.empty {
                Logger.Thaleia.viewModel.logger
                    .info(
                        "Status is notConfigured (not .isConfigured)"
                    )
                return .notConfigured
            }

            switch self.kind {
            case .plex:
                Logger.Thaleia.viewModel.logger
                    .info(
                        "Status is notConfigured (plex)"
                    )
                return .disconnected
            case .seerr:
                let networkResponse = try await Network.getData(
                    request: Network.Request(
                        url: self.credential.url.url!,
                        method: .get
                    ),
                    as: SeerrAPI.Status.self
                )
                if !networkResponse.version.isEmpty {
                    Logger.Thaleia.viewModel.logger
                        .info(
                            "Status is connected (seerr, version: \(networkResponse.version))"
                        )
                    return .connected
                }
                Logger.Thaleia.viewModel.logger
                    .info(
                        "Status is disconnected (fell-through)"
                    )
                return .disconnected
            }
        }
    }
}

extension Server_Old {
    enum Kind: Codable, CaseIterable, Hashable, Identifiable, LabelRepresentable {
        case plex
        case seerr

        var id: Self {
            return self
        }

        var localizedText: String {
            switch self {
            case .plex:
                return String(localized: "Server.Kind.plex")
            case .seerr:
                return String(localized: "Server.Kind.seerr")
            }
        }

        var icon: String {
            switch self {
            case .plex:
                return "film"
            case .seerr:
                return "list.clipboard"
            }
        }
        
        var isSystemIcon: Bool {
            return true
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

        var icon: String {
            switch self {
            case .connected:
                return "checkmark.circle"
            case .disconnected:
                return "xmark.circle"
            case .notConfigured:
                return "questionmark.circle"
            }
        }
        
        var isSystemIcon: Bool {
            return true
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
