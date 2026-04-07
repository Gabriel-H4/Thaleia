//
//  HomeView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/4/26.
//

import SwiftData
import SwiftUI

struct HomeView: View {

    @Environment(DataModel.self) private var model: DataModel
    @Environment(\.modelContext) private var modelContext
    @Query private var servers: [Server]

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
            if servers.isEmpty {
                Text("Configure a server to get started")
            }
            else {
                ForEach(servers) { server in
                    ServerCard(server: server)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    model.isPresentingServerConfigureView.toggle()
                } label: {
                    Label("Add Server", systemImage: "plus")
                }
            }
            ToolbarItem {
                Button {
                    Task {
                        
                    }
                } label: {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(DataModel())
        .modelContainer(for: Server.self, inMemory: true)
}
