//
//  Sidebar_Tab.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/29/25.
//

enum SidebarTab: CaseIterable {
    case home
    case settings
}

extension SidebarTab: Identifiable {
    var id: Int {
        switch self {
        case .home:
            0
        case .settings:
            1
        default:
            9
        }
    }
}

extension SidebarTab: LabelRepresentable {
    var title: String {
        switch self {
        case .home:
            "Home"
        case .settings:
            "Settings"
        default:
            "Unknown"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            "house"
        case .settings:
            "gear"
        default:
            "questionmark.circle"
        }
    }
}
