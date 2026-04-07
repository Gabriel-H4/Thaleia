//
//  ThaleiaApp.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/29/25.
//

import SwiftData
import SwiftUI

@main
struct ThaleiaApp: App {

    @State private var model: DataModel = DataModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
                .containerShape(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                )
                .onAppear {
                    Onboarding.Config.registerDefaultConfig()
                }
                .sheet(isPresented: $model.isPresentingErrorView) {
                    ErrorView()
                        .environment(model)
                }
                .sheet(
                    isPresented: $model.isPresentingServerConfigureView,
                    onDismiss: {
                        model.serverToConfigure = nil
                    }
                ) {
                    ServerConfigureView()
                        .environment(model)
                }
        }
        .modelContainer(
            for: Server.self,
            isAutosaveEnabled: true,
            isUndoEnabled: true
        )
    }
}
