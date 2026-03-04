//
//  SidebarDestination.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/4/26.
//

import Foundation

enum SidebarDestination: Identifiable, CaseIterable {
    case home
    case contentQuality
    case contentRequests
    case keychain

    var id: Int {
        switch self {
        case .home:
            1
        case .contentQuality:
            2
        case .contentRequests:
            3
        case .keychain:
            4
        }
    }

    var title: LocalizedStringResource {
        switch self {
        case .home:
            return "SidebarDestination.title.home"
        case .contentQuality:
            return "SidebarDestination.title.contentQuality"
        case .contentRequests:
            return "SidebarDestination.title.contentRequests"
        case .keychain:
            return "SidebarDestination.title.keychain"
        }
    }

    var icon: String {
        switch self {
        case .home:
            return "house"
        case .contentQuality:
            return "aspectratio"
        case .contentRequests:
            return "list.bullet"
        case .keychain:
            return "key"
        }
    }
}
