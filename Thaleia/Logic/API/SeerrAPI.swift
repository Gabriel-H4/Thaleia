//
//  SeerrAPI.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/13/26.
//

import Foundation

struct SeerrAPI {
    
    struct Status: Codable {
        var version: String
        var commitTag: String
        var updateAvailable: Bool
        var commitsBehind: Int
        var restartRequired: Bool
    }
    
}
