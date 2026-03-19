//
//  ContentView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 1/19/26.
//

import SwiftUI

struct ContentView: View {

    @State private var dataModel = DataModel()

    var body: some View {
        NavigationSplitView {
            // Sidebar
            List(
                SidebarDestination.allCases,
                selection: $dataModel.selectedDestination
            ) { destination in
                Label(destination.title, systemImage: destination.icon)
                    .tag(destination)
            }
        } detail: {
            // Detail
            switch dataModel.selectedDestination {
            case .home:
                HomeView()
            case .contentQuality:
                Text("ContentView.detail.contentQuality")
            case .contentRequests:
                Text("ContentView.detail.contentRequests")
            case .keychain:
                KeychainView()
            }
        }
    }
}
