//
//  ThaleiaURL.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/13/26.
//

import Foundation
import OSLog

struct ThaleiaURL: Equatable {
    var string: String
    var url: URL? {
        URL(string: string)
    }

    func getScheme() -> String? {

        Logger.Thaleia.helpers.logger
            .debug(
                "Got scheme: \(url?.scheme ?? "N/A", privacy: .public) from: \(url?.absoluteString ?? "N/A", privacy: .public)"
            )

        return self.url?.scheme?.lowercased()
    }

    func getPort() -> Int? {

        guard let url = self.url,
            let scheme = url.scheme?.lowercased()
        else {
            return nil
        }

        Logger.Thaleia.helpers.logger
            .debug("Getting port from: \(url, privacy: .public)")

        if let port = url.port {
            Logger.Thaleia.helpers.logger
                .info("Identified port in URL, using \(port, privacy: .public)")
            return port
        }

        switch scheme {
        case "http":
            Logger.Thaleia.helpers.logger.info(
                "Using the default port, 80, for the provided scheme http."
            )
            return 80
        case "https":
            Logger.Thaleia.helpers.logger.info(
                "Using the default port, 443, for the provided scheme https."
            )
            return 443
        default:
            Logger.Thaleia.helpers.logger.error(
                "The scheme provided, \(scheme, privacy: .public), is not supported, and no port was specified in the URL."
            )
            return nil
        }
    }
}
