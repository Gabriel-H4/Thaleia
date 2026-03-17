//
//  KeychainError.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/15/26.
//

import Foundation

extension Keychain {
    enum Error {
        case credentialNotFound
        case invalidURL
        case stringConversionFailed
        case duplicateCredentialsFound
        case other(status: OSStatus)

        var template: ThaleiaErrorTemplate {
            switch self {
            case .credentialNotFound:
                ThaleiaErrorTemplate(
                    errorDescription: String(
                        localized:
                            "Keychain.Error.credentialNotFound.errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized:
                            "Keychain.Error.credentialNotFound.recoverySuggestion"
                    ),
                    failureReason: String(
                        localized:
                            "Keychain.Error.credentialNotFound.failureReason"
                    ),
                    isFatal: false
                )
            case .invalidURL:
                ThaleiaErrorTemplate(
                    errorDescription: String(
                        localized: "Keychain.Error.invalidURL.errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized:
                            "Keychain.Error.invalidURL.recoverySuggestion"
                    ),
                    failureReason: String(
                        localized: "Keychain.Error.invalidURL.failureReason"
                    ),
                    isFatal: false
                )
            case .stringConversionFailed:
                ThaleiaErrorTemplate(
                    errorDescription: String(
                        localized:
                            "Keychain.Error.stringConversionFailed.errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized:
                            "Keychain.Error.stringConversionFailed.recoverySuggestion"
                    ),
                    failureReason: String(
                        localized:
                            "Keychain.Error.stringConversionFailed.failureReason"
                    ),
                    isFatal: false
                )
            case .duplicateCredentialsFound:
                ThaleiaErrorTemplate(
                    errorDescription: String(
                        localized:
                            "Keychain.Error.duplicateCredentialsFound.errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized:
                            "Keychain.Error.duplicateCredentialsFound.recoverySuggestion"
                    ),
                    failureReason: String(
                        localized:
                            "Keychain.Error.duplicateCredentialsFound.failureReason"
                    ),
                    isFatal: true
                )
            case .other(let status):
                ThaleiaErrorTemplate(
                    errorDescription: String(
                        localized:
                            "Keychain.Error.other.\(status).errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized:
                            "Keychain.Error.other.\(status).recoverySuggestion"
                    ),
                    failureReason: String(
                        localized:
                            "Keychain.Error.other.\(status).failureReason"
                    ),
                    isFatal: false
                )
            }
        }
    }
}
