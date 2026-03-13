//
//  ServerCard.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/4/26.
//

import SwiftUI

struct ServerCard: View {

    let server: Server

    var body: some View {
        VStack(alignment: .leading) {
            Text(server.kind.localizedText)
                .font(.headline)
            Label(
                title: {
                    Text(server.status.localizedText)
                },
                icon: {
                    Image(systemName: server.status.systemIcon)
                        .imageScale(.medium)
                        .symbolRenderingMode(.monochrome)
                }
            )
            .font(.subheadline)
            Button("Refresh") {
                Task {
                    let a = try await server.getStatus()
                    print(a.localizedText)
                }
            }
        }
        .padding()
        .background {
            ContainerRelativeShape()
                .fill(server.status.color)
        }
    }
}

#Preview {
    let server = Server(
        kind: .plex,
        credential: Credential(
            username: "demo",
            apiKey: "key123",
            url: ThaleiaURL(string: "https://example.com")
        )
    )
    ServerCard(server: server)
}
