//
//  ConnectedServerType.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/29/25.
//

public enum ConnectedServerType: Codable {
    case plex
    case overseerr
}

extension ConnectedServerType {
    public var name: String {
        switch self {
        case .plex:
            return "ConnectedServer.Type.Name.Plex"
        case .overseerr:
            return "ConnectedServer.Type.Name.Overseerr"
        }
    }
}
