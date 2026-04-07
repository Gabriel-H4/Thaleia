//
//  Server.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 4/2/26.
//

import Foundation
import SwiftData

@Model
final class Server {
    var name: String
    var kind: Server.Kind
    @Attribute(.allowsCloudEncryption) var credentials: Keychain.Credential
    @Transient var version: String = ""
    @Transient var status: Server.Status = .disconnected
    
    init(
        name: String,
        kind: Server.Kind,
        credentials: Keychain.Credential,
        version: String = ""
    ) {
        self.name = name
        self.kind = kind
        self.credentials = credentials
        self.version = version
    }
}
