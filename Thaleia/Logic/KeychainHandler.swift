//
//  KeychainHandler.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 11/20/25.
//

import Foundation
import OSLog
import Security

struct KeychainHandler {

    static func perform(
        _ operation: KeychainHandler.Operation,
        using credential: Credential,
        _ retry: Bool = true
    ) throws(ThaleiaError) -> Credential? {
        Logger.Thaleia.keychain.logger
            .info(
                "Starting to process \(operation.rawValue, privacy: .public) with Credential \(String(describing: credential), privacy: .public)"
            )

        guard let query = buildQuery(operation, using: credential) else {
            throw ThaleiaError(
                using: KeychainError.invalidURL.reusableError
            )
        }

        var operationStatus: OSStatus
        var result: AnyObject?

        switch operation {
        case .get:
            operationStatus = SecItemCopyMatching(
                query as CFDictionary,
                &result
            )
        case .save:
            operationStatus = SecItemAdd(query as CFDictionary, &result)
        case .delete:
            operationStatus = SecItemDelete(query as CFDictionary)
        case .update:
            guard let encodedApiKey = credential.encodedApiKey else {
                throw ThaleiaError(
                    using: KeychainError.stringConversionFailed.reusableError,
                    file: #file,
                    function: #function,
                    line: #line
                )
            }

            let updateAttributes: [String: Any] = [
                kSecValueData as String: encodedApiKey
            ]

            operationStatus = SecItemUpdate(
                query as CFDictionary,
                updateAttributes as CFDictionary
            )
        }

        switch operationStatus {
        case errSecSuccess:
            Logger.Thaleia.keychain.logger.info(
                "KeychainHandler.Operation.\(operation.rawValue, privacy: .public) succeeded with result \(String(describing: credential), privacy: .public)."
            )
            Logger.Thaleia.keychain.logger
                .info(
                    "The Keychain returned: \(String(describing: result), privacy: .public)"
                )
        case errSecDuplicateItem:
            Logger.Thaleia.keychain.logger
                .warning(
                    "KeychainHandler.Operation.\(operation.rawValue, privacy: .public) found multiple matching credentials while searching for \(String(describing: credential), privacy: .public)."
                )
            let _ = try perform(.update, using: credential, false)
        case errSecItemNotFound:
            Logger.Thaleia.keychain.logger.warning(
                "KeychainHandler.Operation.\(operation.rawValue, privacy: .public) failed to find a matching credential while searching for \(String(describing: credential))."
            )
            throw ThaleiaError(
                using: KeychainError.noKeyFound.reusableError,
                file: #file,
                function: #function,
                line: #line
            )
        default:
            Logger.Thaleia.keychain.logger.error(
                "KeychainHandler.Operation.\(operation.rawValue, privacy: .public) failed for an unexpected reason. Error: \(operationStatus.description, privacy: .public), \(String(describing: credential), privacy: .public)."
            )
            throw ThaleiaError(
                using:
                    KeychainError
                    .other(status: operationStatus).reusableError,
                file: #file,
                function: #function,
                line: #line
            )
        }
        if operation == .get {
            guard let data = result as? [String: Any] else {
                Logger.Thaleia.keychain.logger
                    .error(
                        "Unable to convert the Keychain response to a valid dictionary. \(result.debugDescription, privacy: .public)"
                    )
                throw ThaleiaError(
                    using: KeychainError.stringConversionFailed.reusableError,
                    file: #file,
                    function: #function,
                    line: #line
                )
            }

            Logger.Thaleia.keychain.logger.info(
                "Converted data from Keychain into a valid dictionary: \(data.description, privacy: .public)"
            )

            guard let username = data["acct"] as? String,
                let apiKeyData = data["v_Data"] as? Data,
                let apiKey = String(data: apiKeyData, encoding: .utf8)
            else {
                Logger.Thaleia.keychain.logger.error(
                    "Couldn't decode a valid username and/or apiKey from the Keychain response."
                )
                throw ThaleiaError(
                    using: KeychainError.stringConversionFailed.reusableError,
                    file: #file,
                    function: #function,
                    line: #line
                )
            }

            guard let urlProtocol = data["ptcl"] as? String,
                let urlServer = data["srvr"] as? String,
                let urlPort = data["port"] as? Int,
                let url = URL(
                    string: "\(urlProtocol)://\(urlServer):\(String(urlPort))"
                )
            else {
                Logger.Thaleia.keychain.logger.error(
                    "Couldn't decode a valid URL from the Keychain response."
                )
                throw ThaleiaError(
                    using: KeychainError.stringConversionFailed.reusableError,
                    file: #file,
                    function: #function,
                    line: #line
                )
            }

            let credential = Credential(
                username: username,
                apiKey: apiKey,
                url: ThaleiaURL(string: url.absoluteString)
            )

            Logger.Thaleia.keychain.logger
                .info(
                    "Retrieved Credential: \(String(describing: credential), privacy: .public)"
                )
            return credential
        }
        Logger.Thaleia.keychain.logger.info(
            "Returning nil as the operation requested does not require a response"
        )
        return nil
    }
}

extension KeychainHandler {
    enum Operation: String, CaseIterable {
        case get = "get"
        case save = "save"
        case delete = "delete"
        case update = "update"
    }

    static func buildQuery(_ operation: Operation, using credential: Credential)
        -> [String: Any]?
    {

        Logger.Thaleia.keychain.logger.info(
            "Building query for \(String(describing: operation), privacy: .public), using \(String(describing: credential), privacy: .public)"
        )

        guard let encodedApiKey = credential.encodedApiKey,
            let host = credential.url.url?.host(),
            let scheme = credential.url.getScheme(),
            let port = credential.url.getPort()
        else {
            Logger.Thaleia.keychain.logger.error(
                "Unable to build query with a malformed Credential. host, encodedApiKey, scheme or port is nil."
            )
            return nil
        }

        var baseQuery: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: host,
            kSecAttrPort as String: port,
            kSecAttrProtocol as String: scheme,
            kSecAttrAccessible as String:
                kSecAttrAccessibleWhenUnlocked,
            kSecAttrSynchronizable as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        // Filter by username if it contains a value,
        // but exclude update operations
        if !credential.username.isEmpty && operation != .update {
            baseQuery[kSecAttrAccount as String] = credential.username
            Logger.Thaleia.keychain.logger
                .info("Added kSecAttrAccount to baseQuery")
        }

        switch operation {
        case .get:

            // Specify that the Query should return both
            // attributes and data
            baseQuery[kSecReturnAttributes as String] = true
            baseQuery[kSecReturnData as String] = true

            Logger.Thaleia.keychain.logger.info(
                "Added kSecReturnAttributes and kSecReturnData to baseQuery"
            )

        case .save:

            // Include the credential password for save operations
            baseQuery[kSecValueData as String] = encodedApiKey

            Logger.Thaleia.keychain.logger
                .info("Added kSecValueData to baseQuery")

        case .delete, .update:
            break
        }

        return baseQuery
    }
}

extension KeychainHandler {
    enum KeychainError {
        case noKeyFound
        case invalidURL
        case stringConversionFailed
        case other(status: OSStatus)

        var reusableError: ReusableThaleiaError {
            switch self {
            case .noKeyFound:
                ReusableThaleiaError(
                    errorDescription: String(
                        localized: "KeychainError.noKeyFound.errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized: "KeychainError.noKeyFound.recoverySuggestion"
                    ),
                    failureReason: String(
                        localized: "KeychainError.noKeyFound.failureReason"
                    ),
                    isFatal: false
                )
            case .invalidURL:
                ReusableThaleiaError(
                    errorDescription: String(
                        localized: "KeychainError.invalidURL.errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized: "KeychainError.invalidURL.recoverySuggestion"
                    ),
                    failureReason: String(
                        localized: "KeychainError.invalidURL.failureReason"
                    ),
                    isFatal: false
                )
            case .stringConversionFailed:
                ReusableThaleiaError(
                    errorDescription: String(
                        localized:
                            "KeychainError.stringConversionFailed.errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized:
                            "KeychainError.stringConversionFailed.recoverySuggestion"
                    ),
                    failureReason: String(
                        localized:
                            "KeychainError.stringConversionFailed.failureReason"
                    ),
                    isFatal: false
                )
            case .other(let status):
                ReusableThaleiaError(
                    errorDescription: String(
                        localized:
                            "KeychainError.other.\(status).errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized:
                            "KeychainError.other.\(status).recoverySuggestion"
                    ),
                    failureReason: String(
                        localized: "KeychainError.other.\(status).failureReason"
                    ),
                    isFatal: false
                )
            }
        }
    }
}
