//
//  ContentViewDataModel.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/4/26.
//

import SwiftUI

extension ContentView {
    @Observable
    final class DataModel {
        var selectedDestination: SidebarDestination = .home
    }
}
