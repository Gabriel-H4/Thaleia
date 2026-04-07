//
//  ServerCard.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/4/26.
//

import SwiftUI

struct ServerCard: View {

    @Environment(DataModel.self) private var model
    @State var server: Server

    var body: some View {
        VStack(alignment: .leading) {
            Text(server.kind.localizedText)
                .font(.headline)
            Label(
                title: {
                    Text("Status")
                },
                icon: {
                    Image(systemName: "questionmark")
                        .bold()
                        .imageScale(.medium)
                        .symbolRenderingMode(.monochrome)
                }
            )
            .font(.subheadline)
            .padding(.bottom)
            if(true) {
                Button("Configure") {
                    model.isPresentingServerConfigureView = true
                }
            }
            else {
                Button("Info") {
                    
                }
                Label(server.credentials.url.string, systemImage: "link")
                    .lineLimit(1)
                    .truncationMode(.tail)
                if(!server.credentials.username.isEmpty) {
                    Label(server.credentials.username, systemImage: "person.fill")
                }
            }
        }
        .padding()
        .background {
            if #available(macOS 26.0, *) {
                RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                    .fill(.yellow)
                    .glassEffect(
                        in: RoundedRectangle(
                            cornerRadius: 16.0,
                            style: .continuous
                        )
                    )
//                ContainerRelativeShape()
//                    .fill(status.color)
//                    .glassEffect(in: .containerRelative)
            } else {
                // Fallback on earlier versions
                ContainerRelativeShape()
                    .fill(.yellow)
            }
        }

    }
}

#Preview {
    let server = Server(
        name: "Demo Server",
        kind: .plex,
        credentials: Keychain.Credential(
            username: "demo",
            password: "key123",
            url: ThaleiaURL(string: "https://example.com")
        ),
        version: "0.0.1"
    )
    ServerCard(server: server)
        .environment(DataModel())
}
