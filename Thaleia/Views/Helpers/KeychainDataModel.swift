//
//  KeychainDataModel.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 1/14/26.
//

import Foundation
import OSLog
import SwiftUI

extension KeychainView {

    @Observable
    @MainActor
    final class DataModel {

        var credentialUsername: String = ""
        var credentialApiKey: String = ""
        var credentialUrl: String = ""

        var keychainResponse: Credential? = nil
        var keychainError: ThaleiaError? = nil
        var keychainErrorIsShowing: Bool {
            get {
                return self.keychainError != nil
            }

            set(newValue) {
                if !newValue {
                    self.keychainError = nil
                    self.keychainResponse = nil
                }
            }
        }

        func performKeychainOperation(_ operation: KeychainHandler.Operation) {
            do {
                let credential = try buildCredential()
                if let result = try KeychainHandler.perform(
                    operation,
                    using: credential
                ) {
                    Logger.Thaleia.viewModel.logger.info(
                        "Successfully performed \(operation.rawValue, privacy: .public), response: \(String(reflecting: result), privacy: .public)."
                    )
                    self.keychainResponse = result
                }
            } catch {
                self.didEncounterError(error)
            }
        }

        private func buildCredential() throws(ThaleiaError) -> Credential {
            guard let url = URL(string: self.credentialUrl) else {
                throw ThaleiaError(
                    using: KeychainHandler.KeychainError.invalidURL
                        .reusableError,
                    file: #file,
                    function: #function,
                    line: #line
                )
            }
            return Credential(
                username: self.credentialUsername,
                apiKey: self.credentialApiKey,
                url: ThaleiaURL(string: url.absoluteString)
            )
        }

        private func didEncounterError(_ error: ThaleiaError) {
            Logger.Thaleia.viewModel.logger
                .error("\(String(describing: error), privacy: .public)")
            self.keychainError = error
            self.keychainErrorIsShowing = true
        }

    }
}
