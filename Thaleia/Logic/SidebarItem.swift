//
//  SidebarItem.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/17/26.
//

import Foundation

enum SidebarItem: Hashable, Identifiable {
    case localAnalyze
    case seerrIssues
    case seeerrRequests
    
    var id: Self { self }
    
    var title: String {
        switch self {
            case .localAnalyze:
                String(localized: "SidebarItem.local.analyze.title")
            case .seerrIssues:
                String(localized: "SidebarItem.seerr.issues.title")
            case .seeerrRequests:
                String(localized: "SidebarItem.seerr.requests.title")
        }
    }
    
    var icon: String {
        switch self {
            case .localAnalyze:
                String("photo.badge.magnifyingglass")
            case .seerrIssues:
                String("exclamationmark.triangle")
            case .seeerrRequests:
                String("plus.magnifyingglass")
        }
    }
}
