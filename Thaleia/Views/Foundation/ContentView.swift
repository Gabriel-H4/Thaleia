//
//  ContentView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 1/19/26.
//

import SwiftUI

struct ContentView: View {

    @Environment(DataModel.self) private var model: DataModel

    var body: some View {
        @Bindable var model = model
        
        NavigationSplitView {
            // Sidebar
            List(selection: $model.sidebarDestination) {
                ForEach(SidebarDestination.allCases) { destination in
                    Label(destination.title, systemImage: destination.icon)
                        .tag(destination)
                }
            }
        } detail: {
            // Detail
            switch model.sidebarDestination {
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

#Preview {
    ContentView()
        .environment(DataModel())
        .modelContainer(for: Server.self, inMemory: true)
}
