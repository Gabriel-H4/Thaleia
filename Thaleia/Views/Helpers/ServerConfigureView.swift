//
//  ServerConfigureView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/21/26.
//

import SwiftUI

struct ServerConfigureView: View {
    
    @Environment(DataModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    
    @State var url: String = ""
    @State var username: String =  ""
    @State var password: String = ""
    @State var kind: Server.Kind = .plex
    
    var body: some View {
        Form {
            Section {
                TextField(text: $url, prompt: Text("URL - Required")) {
                    Label("URL", systemImage: "link")
                }
                .textContentType(.URL)
                TextField(text: $username, prompt: Text("Username")) {
                    Label("Username", systemImage: "person.fill")
                }
                .textContentType(.username)
                SecureField(text: $password, prompt: Text("Password")) {
                    Label("Password", systemImage: "key.fill")
                }
                .textContentType(.password)
                Picker("Server Kind", selection: $kind) {
                    ForEach(Server.Kind.allCases) { kind in
                        Label(kind.localizedText, systemImage: kind.icon)
                    }
                }
                .labelStyle(.titleAndIcon)
            }
            .labelStyle(.iconOnly)
            .autocorrectionDisabled()
        }
        .padding()
        .onAppear {
            if let server = model.serverToConfigure {
                url = server.credentials.url.string
                username = server.credentials.username
                password = server.credentials.password
                kind = server.kind
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button {
                    dismiss()
                } label: {
                    Label("Dismiss", systemImage: "xmark")
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    if let url = URL(string: url) {
                        model.serverToConfigure = Server(
                            name: "",
                            kind: kind,
                            credentials: Keychain
                                .Credential(
                                    username: username,
                                    password: password,
                                    url: ThaleiaURL(string: url.absoluteString)
                                ),
                            version: ""
                        )
                        dismiss()
                    }
                } label: {
                    Label("Save", systemImage: "plus")
                }
                .disabled(url.isEmpty)
            }
        }
    }
}

#Preview {
    ServerConfigureView()
        .environment(DataModel())
        .modelContainer(for: Server.self, inMemory: true, isAutosaveEnabled: true, isUndoEnabled: true)
}
