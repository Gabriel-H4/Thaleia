//
//  DataModel.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 9/3/26.
//

import Foundation
import SwiftUI

@Observable
final class DataModel {
    var selectedSidebarItem: SidebarItem = SidebarCategory.main.items.first ?? SidebarItem.localAnalyze
    
    init() {}
}
