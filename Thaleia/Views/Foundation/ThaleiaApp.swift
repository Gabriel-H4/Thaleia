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
    
    @State private var dataModel: DataModel = DataModel()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .containerShape(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                )
                .environment(dataModel)
        }
    }
}
