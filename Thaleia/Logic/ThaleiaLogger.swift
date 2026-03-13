//
//  ThaleiaLogger.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 11/24/25.
//

import Foundation
import OSLog

extension Logger {
    
    enum Thaleia: String {
        case helpers = "helpers"
        case keychain = "keychain"
        case media = "media"
        case networking = "networking"
        case viewModel = "view model"
        
        var logger: Logger {
            return Logger(subsystem: Logger.thaleiaSubystem, category: self.rawValue)
        }
    }

    /// Thaleia's bundle identifier, with a default string to fall back on
    static let thaleiaSubystem: String =
        Bundle.main.bundleIdentifier
        ?? "com.gabrielhassebrock.Thaleia.defaultBundle"

    /// Logger for view-related events
    @available(*, deprecated, renamed: "Thaleia.viewModel.logger")
    static let views: Logger = Logger(
        subsystem: Logger.thaleiaSubystem,
        category: "views"
    )

    /// Logger for networking events
    @available(*, deprecated, renamed: "Thaleia.networking.logger")
    static let networking: Logger = Logger(
        subsystem: Logger.thaleiaSubystem,
        category: "networking"
    )

    /// Logger for Keychain-related events
    @available(*, deprecated, renamed: "Thaleia.keychain.logger")
    static let keychain: Logger = Logger(
        subsystem: Logger.thaleiaSubystem,
        category: "keychain"
    )
    
    /// Logger for URL
    @available(*, deprecated, renamed: "Thaleia.helpers.logger")
    static let urlBuilder: Logger = Logger(
        subsystem: Logger.thaleiaSubystem,
        category: "urlBuilder"
    )

}
