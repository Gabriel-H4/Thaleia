//
//  SidebarTab.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/29/25.
//

import SwiftUI

public enum SidebarTab: CaseIterable {
    case home
    case settings
}

extension SidebarTab: Identifiable {
    public var id: Int {
        switch self {
        case .home:
            0
        case .settings:
            1
        }
    }
}

extension SidebarTab: LabelRepresentable {
    public var title: LocalizedStringKey {
        switch self {
        case .home:
            "SidebarTab.Title.Home"
        case .settings:
            "SidebarTab.Title.Settings"
        }
    }
    
    public var icon: String {
        switch self {
        case .home:
            "house"
        case .settings:
            "gear"
        }
    }
}
