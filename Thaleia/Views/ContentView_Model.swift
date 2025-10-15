//
//  ContentView_Model.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/29/25.
//

import Foundation
import SwiftUI

@Observable
final class ViewModel {
    var selected_sidebar_tab: SidebarTab = SidebarTab.home
    var preferred_tab: NavigationSplitViewColumn = .sidebar
}
