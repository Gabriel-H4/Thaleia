//
//  ConnectedServer.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/29/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
public final class ConnectedServerClass: Identifiable {
    @Attribute(.unique) public private(set) var id: UUID
    public private(set) var name: String
    public var status: ConnectedServerStatus {
        .connecting
    }
    public private(set) var baseURL: String
    public private(set) var apiKey: String
    public private(set) var type: ConnectedServerType
    
    init(baseURL: String, name: String = "", apiKey: String, type: ConnectedServerType) {
        self.id = UUID()
        self.name = name.isEmpty ? type.name : name
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.type = type
    }
    
    func getData(at: String, using: [String: Any]) async -> [String: Any]? {
        var value: [String: Any]? = nil
        
        if let url = URL(string: "\(self.baseURL)\(at)") {
            
        }
        else {
            print("URL is improperly formatted. Please try again.")
        }
        
        return value
    }
    
    func getServerStatus() {
        switch self.type {
        case .plex:
            print("Fetching Plex data from \(self.baseURL)")
        case .overseerr:
            print("Fetching Overseerr data from \(self.baseURL)")
        }
    }
    
    @MainActor @ObservationIgnored static let templates: [ConnectedServerClass] = [
        ConnectedServerClass(
            baseURL: "http://127.0.0.1:5335/",
            apiKey: "change-me-1",
            type: .plex
        ),
        ConnectedServerClass(
            baseURL: "http://127.0.0.1:8080/",
            apiKey: "change-me-2",
            type: .overseerr
        )
    ]
}
