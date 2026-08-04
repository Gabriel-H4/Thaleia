//
//  SidebarDestination.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/17/26.
//

enum SidebarDestination: CaseIterable, Hashable, Identifiable {
    
    case local
    case seerr
    
    var id: Self { self }
    
    var title: String {
        switch self {
            case .local:
                String(localized: "SidebarDestination.local.title")
            case .seerr:
                String(localized: "SidebarDestination.seerr.title")
        }
    }
}
