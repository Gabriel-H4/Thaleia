//
//  ThaleiaURL.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/13/26.
//

import Foundation

struct ThaleiaURL {
    static func getScheme(from url: URL) -> String? {
        switch url.scheme?.lowercased() {
        case "http":
            return kSecAttrProtocolHTTP as String
        case "https":
            return kSecAttrProtocolHTTPS as String
        default:
            return nil
        }
    }

    static func getPort(from url: URL) -> Int? {
        if url.port != nil {
            return url.port
        }

        switch url.scheme?.lowercased() {
        case "http":
            return 80
        case "https":
            return 443
        default:
            return nil
        }
    }
}
