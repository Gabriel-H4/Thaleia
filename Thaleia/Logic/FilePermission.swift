//
//  FilePermission.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 8/23/26.
//

import Foundation
import SwiftUI

enum FilePermission: Hashable, Identifiable {

    case readable(value: Bool), writable(value: Bool), executable(value: Bool)
    
    var id: Self { self }
    
    var label: LocalizedStringResource {
        switch self {
            case .readable(let value):
                if value {
                    "FilePermission.readable.true.label"
                }
                else {
                    "FilePermission.readable.false.label"
                }
            case .writable(let value):
                if value {
                    "FilePermission.writable.true.label"
                }
                else {
                    "FilePermission.writable.false.label"
                }
            case .executable(let value):
                if value {
                    "FilePermission.executable.true.label"
                }
                else {
                    "FilePermission.executable.false.label"
                }
        }
    }
    
    var icon: String {
        switch self {
            case .readable:
                "eye"
            case .writable:
                "pencil"
            case .executable:
                "apple.terminal"
        }
    }
    
    var iconVariant: SymbolVariants {
        switch self {
            case .readable(let value):
                if value {
                    .none
                }
                else {
                    .slash
                }
            case .writable(let value):
                if value {
                    .none
                }
                else {
                    .slash
                }
            case .executable(let value):
                if value {
                    .none
                }
                else {
                    .slash
                }
        }
    }
    
    static func create(readable: Bool = false, writable: Bool = false, executable: Bool = false) -> [Self] {
        return [
            .readable(value: readable),
            .writable(value: writable),
            .executable(value: executable)
        ]
    }
}
