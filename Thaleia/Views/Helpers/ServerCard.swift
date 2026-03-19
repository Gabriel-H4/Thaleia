//
//  ServerCard.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/4/26.
//

import SwiftUI

struct ServerCard: View {
    
    @State private var dataModel: DataModel
    
    init(server: Server) {
        self.dataModel = ServerCard.DataModel(server: server)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(dataModel.server.kind.localizedText)
                .font(.headline)
            Label(
                title: {
                    Text(dataModel.status.localizedText)
                },
                icon: {
                    Image(systemName: dataModel.status.systemIcon)
                        .imageScale(.medium)
                        .symbolRenderingMode(.monochrome)
                }
            )
            .font(.subheadline)
            if #available(macOS 26.0, *) {
                Button("Refresh") {
                    Task {
                        await dataModel.refreshStatus()
                    }
                }
                .buttonStyle(GlassButtonStyle())
            }
            else {
                Button("Refresh") {
                    Task {
                        await dataModel.refreshStatus()
                    }
                }
            }
        }
        .padding()
        .background {
            if #available(macOS 26.0, *) {
                ContainerRelativeShape()
                    .fill(dataModel.status.color)
                    .glassEffect(in: .containerRelative)
            } else {
                    // Fallback on earlier versions
                ContainerRelativeShape()
                    .fill(dataModel.status.color)
            }
        }
        .sheet(isPresented: $dataModel.errorViewIsShowing) {
            ErrorView(error: dataModel.error)
        }
    }
}

#Preview {
    let server = Server(
        kind: .plex,
        credential: Keychain.Credential(
            username: "demo",
            password: "key123",
            url: ThaleiaURL(string: "https://example.com")
        )
    )
    ServerCard(server: server)
}
