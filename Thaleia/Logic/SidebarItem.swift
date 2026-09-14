//
//  SidebarItem.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/17/26.
//

import Foundation

enum SidebarItem: Identifiable, LabelRepresentable {

    case localAnalyze
    case seerrIssues
    case seeerrRequests

    var id: Self { self }

    var title: LocalizedStringResource {
        switch self {
        case .localAnalyze:
            "SidebarItem.local.analyze.title"
        case .seerrIssues:
            "SidebarItem.seerr.issues.title"
        case .seeerrRequests:
            "SidebarItem.seerr.requests.title"
        }
    }

    var icon: SFSymbol {
        switch self {
        case .localAnalyze:
            "photo.badge.magnifyingglass"
        case .seerrIssues:
            "exclamationmark.triangle"
        case .seeerrRequests:
            "plus.magnifyingglass"
        }
    }
}
