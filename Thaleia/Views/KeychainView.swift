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
                TextField("Lookup Tag", text: $dataModel.keychainLookupTag)
                TextField("Custom Value", text: $dataModel.keychainValueToInsert)
            }
            
            Section {
                Text("Lookup Tag: \(dataModel.keychainLookupTag.isEmpty ? "nil" : dataModel.keychainLookupTag)")
                Text("Value: \(dataModel.keychainResponse ?? "nil")")
            }
            
            Section {
                Text(dataModel.keychainError?.localizedDescription ?? "")
                Button("Save") {
                    dataModel.saveToKeychain()
                }
                .disabled(dataModel.keychainLookupTag.isEmpty)

                Button("Get") {
                    dataModel.fetchFromKeychain()
                }
                .disabled(dataModel.keychainLookupTag.isEmpty)

                Button("Delete") {
                    dataModel.deleteFromKeychain()
                }
                .disabled(dataModel.keychainLookupTag.isEmpty)
            }
        }
        .padding()
        .navigationTitle("Keychain View")
        .sheet(isPresented: $dataModel.keychainErrorIsShowing) {
            ErrorView(error: dataModel.keychainError ?? KeychainHandler.KeychainError.other.error)
        }
    }
}

#Preview {
    KeychainView()
}
