//
//  Keychain.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/14/26.
//

import Foundation
import OSLog
import Security

struct Keychain {

    private init() {}

    static func perform(
        _ action: Keychain.Action,
        using credential: Keychain.Credential,
        _ retry: Bool = true
    ) throws(ThaleiaError) -> Credential? {
        Logger.Thaleia.keychain.logger
            .info(
                "Starting to process action \(action.rawValue, privacy: .public) with Credential \(String(describing: credential), privacy: .public)"
            )
        
        guard let query = buildQuery(for: action, using: credential) else {
            throw ThaleiaError(
                using: Keychain.Error.invalidURL.template
            )
        }
        
        var operationStatus: OSStatus
        var result: AnyObject?
        
        switch action {
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
                guard let encodedPassword = credential.encodedPassword else {
                    throw ThaleiaError(
                        using: Keychain.Error.stringConversionFailed.template,
                        file: #file,
                        function: #function,
                        line: #line
                    )
                }
                
                let updateAttributes: [String: Any] = [
                    kSecAttrAccount as String: credential.username,
                    kSecValueData as String: encodedPassword
                ]
                
                operationStatus = SecItemUpdate(
                    query as CFDictionary,
                    updateAttributes as CFDictionary
                )
        }
        
        switch operationStatus {
            case errSecSuccess:
                Logger.Thaleia.keychain.logger.info(
                    "Keychain.Action.\(action.rawValue, privacy: .public) succeeded with result \(String(describing: credential), privacy: .public)."
                )
                Logger.Thaleia.keychain.logger
                    .info(
                        "The Keychain returned: \(String(describing: result), privacy: .public)"
                    )
            case errSecDuplicateItem:
                Logger.Thaleia.keychain.logger
                    .warning(
                        "Keychain.Action.\(action.rawValue, privacy: .public) found multiple matching credentials while searching for \(String(describing: credential), privacy: .public)."
                    )
                if retry {
                    let _ = try perform(.update, using: credential, false)
                }
                else {
                    throw ThaleiaError(
                        using: Keychain.Error.duplicateCredentialsFound.template
                    )
                }
            case errSecItemNotFound:
                Logger.Thaleia.keychain.logger.warning(
                    "Keychain.Action.\(action.rawValue, privacy: .public) failed to find a matching credential while searching for \(String(describing: credential))."
                )
                throw ThaleiaError(
                    using: Keychain.Error.credentialNotFound.template,
                    file: #file,
                    function: #function,
                    line: #line
                )
            default:
                Logger.Thaleia.keychain.logger.error(
                    "Keychain.Action.\(action.rawValue, privacy: .public) failed for an unexpected reason. Error: \(operationStatus.description, privacy: .public), \(String(describing: credential), privacy: .public)."
                )
                throw ThaleiaError(
                    using:
                        Keychain.Error
                        .other(status: operationStatus).template,
                    file: #file,
                    function: #function,
                    line: #line
                )
        }
        if action == .get {
            guard let data = result as? [String: Any] else {
                Logger.Thaleia.keychain.logger
                    .error(
                        "Unable to convert the Keychain response to a valid dictionary. \(result.debugDescription, privacy: .public)"
                    )
                throw ThaleiaError(
                    using: Keychain.Error.stringConversionFailed.template,
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
                    using: Keychain.Error.stringConversionFailed.template,
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
                    using: Keychain.Error.stringConversionFailed.template,
                    file: #file,
                    function: #function,
                    line: #line
                )
            }
            
            let credential = Credential(
                username: username,
                password: apiKey,
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
    
    static func buildQuery(
        for action: Keychain.Action,
        using credential: Keychain.Credential
    ) -> [String: Any]? {
        Logger.Thaleia.keychain.logger.info(
            "Building query for \(String(describing: action), privacy: .public), using \(String(describing: credential), privacy: .public)"
        )
        
        guard let encodedApiKey = credential.encodedPassword,
              let host = credential.url.url?.host(),
              let scheme = credential.url.scheme,
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
        if !credential.username.isEmpty && action != .update {
            baseQuery[kSecAttrAccount as String] = credential.username
            Logger.Thaleia.keychain.logger
                .info("Added kSecAttrAccount to baseQuery")
        }
        
        switch action {
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
