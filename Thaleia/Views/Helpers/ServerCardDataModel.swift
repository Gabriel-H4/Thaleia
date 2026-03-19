//
//  ServerCardDataModel.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/18/26.
//

import Foundation
import SwiftUI
import OSLog

extension ServerCard {
    
    @Observable
    @MainActor
    final class DataModel {
        var server: Server
        var status: Server.ConnectionStatus = .notConfigured
        var error: ThaleiaError? = nil
        var errorViewIsShowing: Bool {
            get {
                return self.error != nil
            }
            
            set(newValue) {
                if !newValue {
                    self.error = nil
                    self.status = .disconnected
                }
            }
        }
        
        init(server: Server) {
            self.server = server
        }
        
        func refreshStatus() async {
            do {
                Logger.Thaleia.viewModel.logger
                    .info(
                        "Refreshing status for server: \(self.server.credential.url.string)"
                    )
                if !self.server.isConfigured {
                    Logger.Thaleia.viewModel.logger
                        .info(
                            "Status is notConfigured (not .isConfigured)"
                        )
                    self.status = .notConfigured
                    return
                }
                switch self.server.kind {
                    case .plex:
                        self.status = .notConfigured
                        Logger.Thaleia.viewModel.logger
                            .info(
                                "Status is notConfigured (plex)"
                            )
                        return
                    case .seerr:
                        let networkResponse = try await Network.getData(
                            request: Network.Request(
                                url: self.server.credential.url.url!,
                                method: .get
                            ),
                            as: SeerrAPI.Status.self
                        )
                        if networkResponse.version != "" {
                            Logger.Thaleia.viewModel.logger
                                .info(
                                    "Status is connected (seerr, version: \(networkResponse.version))"
                                )
                            self.status = .connected
                            return
                        }
                        Logger.Thaleia.viewModel.logger
                            .info(
                                "Status is disconnected (fell-through)"
                            )
                        self.status = .disconnected
                        return
                }
            }
            catch {
                self.error = error
                self.errorViewIsShowing = true
            }
        }
    }
    
}
