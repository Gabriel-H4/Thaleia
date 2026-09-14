//
//  FilePermission.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 8/23/26.
//

import Foundation
import SwiftUI

enum FilePermission: Hashable, Identifiable, LabelRepresentable {

    case readable(value: Bool)
    case writable(value: Bool)
    case executable(value: Bool)

    var id: Self { self }

    var title: LocalizedStringResource {
        switch self {
        case .readable(let value):
            if value {
                "FilePermission.readable.true.title"
            } else {
                "FilePermission.readable.false.title"
            }
        case .writable(let value):
            if value {
                "FilePermission.writable.true.title"
            } else {
                "FilePermission.writable.false.title"
            }
        case .executable(let value):
            if value {
                "FilePermission.executable.true.title"
            } else {
                "FilePermission.executable.false.title"
            }
        }
    }

    var icon: SFSymbol {
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
            } else {
                .slash
            }
        case .writable(let value):
            if value {
                .none
            } else {
                .slash
            }
        case .executable(let value):
            if value {
                .none
            } else {
                .slash
            }
        }
    }

    static func create(
        readable: Bool = false,
        writable: Bool = false,
        executable: Bool = false
    ) -> [Self] {
        return [
            .readable(value: readable),
            .writable(value: writable),
            .executable(value: executable),
        ]
    }
}
