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
                    "KeychainView.TextField.CredentialAPIKey.\(dataModel.keychainResponse?.apiKey ?? "")",
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
                    ForEach(KeychainHandler.Operation.allCases, id: \.self) {
                        operation in
                        Button(operation.rawValue.capitalized) {
                            dataModel.performKeychainOperation(operation)
                        }
                    }
                }
                .padding()
            }
            .disabled(dataModel.credentialUrl.isEmpty)
        }
        
        .padding()
        .navigationTitle("Keychain View")
        .sheet(isPresented: $dataModel.keychainErrorIsShowing) {
            if let error = dataModel.keychainError {
                ErrorView(error: error)
            } else {
                ContentUnavailableView(
                    "ContentUnavailableView.Label.NoErrorFound.Text",
                    image: "stethoscope"
                )
            }
        }
    }
}

#Preview {
    KeychainView()
}
