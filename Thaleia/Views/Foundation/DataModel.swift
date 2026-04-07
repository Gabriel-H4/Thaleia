//
//  DataModel.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/23/26.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class DataModel {
    
    // MARK: Error Handling
    var error: ThaleiaError?
    var isPresentingErrorView: Bool {
        get {
            return self.error != nil
        }
        set(newValue) {
            if newValue {
                self.error = nil
            }
        }
    }
    
    // MARK: ContentView
    
    var sidebarDestination: SidebarDestination = .home

    
    // MARK: HomeView
    
    var isPresentingServerConfigureView: Bool = false

    // MARK: ServerConfigureView
    
    var serverToConfigure: Server?
}
