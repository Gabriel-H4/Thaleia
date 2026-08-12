//
//  SidebarCategory.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 8/10/26.
//

import Foundation

enum SidebarCategory: CaseIterable, Hashable, Identifiable {
    case main
    case seerr
    
    var id: Self { self }
    
    var title: String {
        switch self {
            case .main:
                String(localized: "SidebarCategory.main.title")
            case .seerr:
                String(localized: "SidebarCategory.seerr.title")
        }
    }
    
    var items: [SidebarItem] {
        switch self {
            case .main:
                [.localAnalyze]
            case .seerr:
                [.seeerrRequests, .seerrIssues]
        }
    }
}
