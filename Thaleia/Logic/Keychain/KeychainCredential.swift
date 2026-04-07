//
//  KeychainCredential.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/14/26.
//

import Foundation

extension Keychain {
    struct Credential: Equatable, Codable {
        var username: String = ""
        var password: String = ""
        var url: ThaleiaURL
        
        var encodedPassword: Data? {
            return self.password.data(using: .utf8)
        }
        
        static let empty: Credential = Credential(url: ThaleiaURL(string: ""))
    }
}
