//
//  KeychainHandler.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 11/20/25.
//

import Foundation
import OSLog
import Security

final class KeychainHandler {

    @MainActor static let main = KeychainHandler()

    private init() {}

    enum KeychainError {
        case noKeyFound
        case other

        var error: ThaleiaError {
            switch self {
            case .noKeyFound:
                ThaleiaError(
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
            case .other:
                ThaleiaError(
                    errorDescription: String(
                        localized: "KeychainError.other.errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized: "KeychainError.other.recoverySuggestion"
                    ),
                    failureReason: String(
                        localized: "KeychainError.other.failureReason"
                    ),
                    isFatal: false
                )
            }
        }
    }

    func save(_ value: String, withKey key: String) throws(ThaleiaError) {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data,
                kSecAttrAccessible as String:
                    kSecAttrAccessibleWhenUnlocked,
            ]

            let itemAddStatus = SecItemAdd(query as CFDictionary, nil)

            if itemAddStatus == errSecDuplicateItem {
                let attributes: [String: Any] = [
                    kSecValueData as String: data
                ]
                let itemUpdateStatus = SecItemUpdate(
                    query as CFDictionary,
                    attributes as CFDictionary
                )
                
                guard itemUpdateStatus == errSecSuccess else {
                    switch itemUpdateStatus {
                    case errSecItemNotFound:
                        throw KeychainError.noKeyFound.error
                    default:
                        throw KeychainError.other.error
                    }
                }
            }
            
            guard itemAddStatus == errSecSuccess else {
                switch itemAddStatus {
                case errSecDuplicateItem:
                    return
                default:
                    throw KeychainError.other.error
                }
            }
        }
    }

    func get(withKey key: String) throws(ThaleiaError) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        var dataTypeRef: AnyObject?
        let getKeyStatus = SecItemCopyMatching(
            query as CFDictionary,
            &dataTypeRef
        )

        if getKeyStatus == errSecSuccess,
            let data = dataTypeRef as? Data
        {
            return String(data: data, encoding: .utf8)
        }

        throw KeychainError.noKeyFound.error
    }

    func remove(atKey key: String) throws(ThaleiaError) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        let removeKeyStatus = SecItemDelete(query as CFDictionary)

        if removeKeyStatus == errSecItemNotFound {
            throw KeychainError.noKeyFound.error
        }

        guard removeKeyStatus == errSecSuccess else {
            throw KeychainError.other.error
        }

    }
}
