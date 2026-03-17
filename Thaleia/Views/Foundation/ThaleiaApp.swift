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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Onboarding.Config.registerDefaultConfig()
                }
        }
    }
}
