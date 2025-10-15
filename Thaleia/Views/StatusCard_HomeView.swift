//
//  StatusCard_HomeView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/31/25.
//

import SwiftData
import SwiftUI

struct StatusCard_HomeView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var servers: [ConnectedServerClass]
    
    var body: some View {
        HStack {
            ForEach(servers) { server in
                StatusCardView(server: server)
            }
        }
    }
}

#Preview {
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ConnectedServerClass.self, configurations: config)
    
    for template in ConnectedServerClass.templates {
        container.mainContext.insert(template)
    }
    
    return StatusCard_HomeView()
        .modelContainer(container)
}
