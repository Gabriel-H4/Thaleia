//
//  NetworkSession.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/13/26.
//

import Foundation

extension Network {
    struct Session {
        static let config = URLSessionConfiguration.ephemeral
        static let session = URLSession(configuration: Session.config)
        
        private init() {}
    }
}
