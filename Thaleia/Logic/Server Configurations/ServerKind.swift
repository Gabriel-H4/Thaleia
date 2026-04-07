//
//  ServerKind.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 4/6/26.
//

extension Server {
    enum Kind: CaseIterable, Codable, Hashable, Identifiable, LabelRepresentable {
        case plex
        case seerr
        
        var id: Self {
            return self
        }
        
        var localizedText: String {
            switch self {
                case .plex:
                    return String(localized: "Server.Kind.plex")
                case .seerr:
                    return String(localized: "Server.Kind.seerr")
            }
        }
        
        var icon: String {
            switch self {
                case .plex:
                    return "film"
                case .seerr:
                    return "list.clipboard"
            }
        }
        
        var isSystemIcon: Bool {
            return true
        }
    }
}
