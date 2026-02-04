//
//  ThaleiaLogger.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 11/24/25.
//

import Foundation
import OSLog

extension Logger {
    
    /// Thaleia's bundle identifier, with a default string to fall back on
    private static let thaleiaSubystem: String =
        Bundle.main.bundleIdentifier
        ?? "com.gabrielhassebrock.Thaleia.defaultBundle"
    
    /// Logger for view-related events
    static let views: Logger = Logger(
        subsystem: Logger.thaleiaSubystem,
        category: "views"
    )
    
    /// Logger for networking events
    static let networking: Logger = Logger(
        subsystem: Logger.thaleiaSubystem,
        category: "networking"
    )
    
    /// Logger for Keychain-related events
    static let keychain: Logger = Logger(
        subsystem: Logger.thaleiaSubystem,
        category: "keychain"
    )
    
}
