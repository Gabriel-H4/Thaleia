//
//  ConnectedServerStatus.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/29/25.
//

import SwiftUI

public enum ConnectedServerStatus: Codable {
    case connecting
    case connected
    case disconnected
}

extension ConnectedServerStatus {
    public var description: String {
        switch self {
        case .connecting:
            "connecting"
        case .connected:
            "connected"
        case .disconnected:
            "disconnected"
        }
    }
    
    public var icon: String {
        switch self {
        case .connecting:
            "dot.radiowaves.left.and.right"
        case .connected:
            "checkmark.circle.fill"
        case .disconnected:
            "xmark.circle.fill"
        }
    }
    
    public var color: Color {
        switch self {
        case .connecting:
                .yellow
        case .connected:
                .green
        case .disconnected:
                .red
        }
    }
}
