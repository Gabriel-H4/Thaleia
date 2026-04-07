//
//  KeychainView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 11/20/25.
//

import SwiftUI

struct KeychainView: View {

    @State private var dataModel = DataModel()

    var body: some View {
        Form {
            
            Section {
                TextField(
                    "KeychainView.TextField.CredentialURL",
                    text: $dataModel.credentialUrl,
                    prompt: Text("TextField.Required")
                )
                TextField(
                    "KeychainView.TextField.CredentialUsername",
                    text: $dataModel.credentialUsername,
                    prompt: Text("TextField.Optional")
                )
                TextField(
                    "KeychainView.TextField.CredentialAPIKey",
                    text: $dataModel.credentialApiKey,
                    prompt: Text("TextField.Optional")
                )
            } header: {
                Label(
                    "KeychainView.Label.CredentialSearch",
                    systemImage: "line.3.horizontal.decrease"
                )
            }

            Spacer()
 
            Section {
                Label(
                    "KeychainView.TextField.CredentialURL.\(dataModel.keychainResponse?.url.string ?? "")",
                    systemImage: "link"
                )
                Label(
                    "KeychainView.TextField.CredentialUsername.\(dataModel.keychainResponse?.username ?? "")",
                    systemImage: "person.fill"
                )
                Label(
                    "KeychainView.TextField.CredentialAPIKey.\(dataModel.keychainResponse?.password ?? "")",
                    systemImage: "key.fill"
                )
            } header: {
                Label(
                    "KeychainView.Label.CredentialResults",
                    systemImage: "key.2.on.ring"
                )
            }

            Section {
                HStack {
                    ForEach(Keychain.Action.allCases, id: \.self) {
                        action in
                        Button(action.rawValue.capitalized) {
                            dataModel.performKeychainOperation(action)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
            }
            .disabled(dataModel.credentialUrl.isEmpty)
        }
        
        .padding()
        .navigationTitle("KeychainView.NavigationTitle")
        .sheet(isPresented: $dataModel.keychainErrorIsShowing) {
            ErrorView()
        }
    }
}

#Preview {
    KeychainView()
}
