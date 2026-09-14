//
//  Property.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 9/14/26.
//

import Foundation

struct Property: Equatable, Identifiable, LabelRepresentable {
    let id = UUID()
    var title: LocalizedStringResource
    var icon: SFSymbol
    var underlyingValue: any CustomStringConvertible

    static func == (_ lhs: Property, _ rhs: Property) -> Bool {
        return lhs.id == rhs.id
    }
}
