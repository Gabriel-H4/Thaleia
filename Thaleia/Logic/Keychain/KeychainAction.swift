//
//  KeychainAction.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/14/26.
//

import Foundation

extension Keychain {
    enum Action: String, CaseIterable {
        case get = "get"
        case save = "save"
        case delete = "delete"
        case update = "update"
    }
}
