//
//  Credential.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/13/26.
//

import Foundation

struct Credential {
    var username: String
    var apiKey: String
    var url: URL

    var encodedApiKey: Data? {
        return apiKey.data(using: .utf8)
    }
    var port: Int? {
        return ThaleiaURL.getPort(from: url)
    }
    var scheme: String? {
        return ThaleiaURL.getScheme(from: url)
    }

    init(username: String = "", apiKey: String = "", url: URL) {
        self.username = username
        self.apiKey = apiKey
        self.url = url
    }
}
