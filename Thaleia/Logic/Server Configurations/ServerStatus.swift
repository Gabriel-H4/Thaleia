//
//  ServerStatus.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 4/6/26.
//

import SwiftUI

extension Server {
    enum Status: LabelRepresentable {
        case connected
        case disconnected
        case unknown
        
        var localizedText: String {
            switch self {
                case .connected:
                    return String(localized: "Server.Status.connected")
                case .disconnected:
                    return String(localized: "Server.Status.disconnected")
                case .unknown:
                    return String(localized: "Server.Status.unknown")
            }
        }
        
        var icon: String {
            switch self {
                case .connected:
                    return "checkmark.circle"
                case .disconnected:
                    return "xmark.circle"
                case .unknown:
                    return "questionmark.circle"
            }
        }
        
        var isSystemIcon: Bool {
            return true
        }
        
        var color: Color {
            switch self {
                case .connected:
                    return Color.green.opacity(0.25)
                case .disconnected:
                    return Color.red.opacity(0.25)
                case .unknown:
                    return Color.yellow.opacity(0.25)
            }
        }
    }
}
