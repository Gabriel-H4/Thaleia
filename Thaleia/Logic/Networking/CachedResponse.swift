//
//  CachedResponse.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 4/2/26.
//

import Foundation

extension Network {
    struct CachedResponse {
        let value: Any
        let expiration: Date
        
        var isExpired: Bool {
            return Date.now >= expiration
        }
        
        var isNotExpired: Bool {
            return Date.now < expiration
        }
    }
}
