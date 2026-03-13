//
//  PlexAPI.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/13/26.
//

import Foundation

struct PlexAPI {
    
    struct Status: Codable {
        let version: String
        let friendlyName: String
        let mediaProviders: Bool
        
        private enum RootKeys: String, CodingKey {
            case mediaContainer = "MediaContainer"
        }
        
        private enum MediaContainerKeys: String, CodingKey {
            case version
            case friendlyName
            case mediaProviders
        }
        
        init(from decoder: Decoder) throws {
            let root = try decoder.container(keyedBy: RootKeys.self)
            let container = try root.nestedContainer(
                keyedBy: MediaContainerKeys.self,
                forKey: .mediaContainer
            )
            
            version = try container.decode(String.self, forKey: .version)
            friendlyName = try container.decode(String.self, forKey: .friendlyName)
            mediaProviders = try container.decode(Bool.self, forKey: .mediaProviders)
        }
        
        func encode(to encoder: Encoder) throws {
            var root = encoder.container(keyedBy: RootKeys.self)
            var container = root.nestedContainer(
                keyedBy: MediaContainerKeys.self,
                forKey: .mediaContainer
            )
            
            try container.encode(version, forKey: .version)
            try container.encode(friendlyName, forKey: .friendlyName)
            try container.encode(mediaProviders, forKey: .mediaProviders)
        }
    }
}
