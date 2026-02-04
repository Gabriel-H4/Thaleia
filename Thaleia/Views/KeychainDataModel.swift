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
    class DataModel {
        var keychainLookupTag: String = ""
        var keychainValueToInsert: String = ""
        var keychainResponse: String? = nil
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

        func saveToKeychain() {
            do {
                try KeychainHandler.main.save(
                    self.keychainValueToInsert,
                    withKey: self.keychainLookupTag
                )
            } catch {
                self.keychainError = error
            }
        }

        func fetchFromKeychain() {
            do {
                self.keychainResponse = try KeychainHandler.main
                    .get(withKey: self.keychainLookupTag)
            } catch {
                self.keychainError = error
            }
        }

        func deleteFromKeychain() {
            do {
                try KeychainHandler.main.remove(atKey: self.keychainLookupTag)
            } catch {
                self.keychainError = error
            }
        }

    }
}
