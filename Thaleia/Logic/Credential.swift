//
//  Credential.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/13/26.
//

import Foundation

struct Credential: Equatable {
    var username: String
    var apiKey: String
    var url: ThaleiaURL

    var encodedApiKey: Data? {
        return apiKey.data(using: .utf8)
    }

    init(username: String = "", apiKey: String = "", url: ThaleiaURL) {
        self.username = username
        self.apiKey = apiKey
        self.url = url
    }

    static let empty = Credential(url: ThaleiaURL(string: ""))
}
